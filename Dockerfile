# syntax=docker/dockerfile:1

ARG RUBY_VERSION=3.4.4
FROM ruby:${RUBY_VERSION}-slim AS base

WORKDIR /rails

# Variáveis de ambiente globais
ENV BUNDLE_PATH="/usr/local/bundle" \
    PATH="/usr/local/bundle/bin:$PATH"

# Instala pacotes básicos do sistema + Node.js
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl libjemalloc2 libvips postgresql-client nodejs npm && \
    npm install -g yarn && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Etapa de build das dependências e precompilação
FROM base AS build

# Instala dependências de build para gems nativas
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential git libpq-dev libyaml-dev pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copia arquivos do bundle e instala as gems
COPY Gemfile Gemfile.lock ./

ARG RAILS_ENV=development
ENV RAILS_ENV=$RAILS_ENV

RUN if [ "$RAILS_ENV" = "production" ]; then \
    bundle config set without 'development test'; \
    bundle install --deployment; \
  else \
    bundle install; \
  fi && \
  bundle exec bootsnap precompile --gemfile

# Copia o restante do app
COPY . .

# Garante permissões corretas
RUN chmod +x ./bin/*

# Precompila diretórios do bootsnap
RUN bundle exec bootsnap precompile app/ lib/

# Precompila os assets caso seja produção
RUN if [ "$RAILS_ENV" = "production" ]; then \
      SECRET_KEY_BASE=dummydummydummydummydummydummydummydummy \
      ./bin/rails assets:precompile; \
    fi

# Etapa final (imagem de execução)
FROM base

# Reaplica variáveis de ambiente
ENV BUNDLE_PATH="/usr/local/bundle" \
    PATH="/usr/local/bundle/bin:$PATH"

# Copia os arquivos do app e as gems da imagem de build
COPY --from=build --chown=rails:rails /rails /rails
COPY --from=build --chown=rails:rails /usr/local/bundle /usr/local/bundle

# Cria usuário não-root
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails /rails /usr/local/bundle

USER rails

# Configura o entrypoint customizado
COPY --chown=rails:rails bin/docker-entrypoint /rails/bin/docker-entrypoint
RUN chmod +x /rails/bin/docker-entrypoint
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Porta padrão do servidor
ARG PORT=3000
ENV PORT=$PORT
EXPOSE $PORT

# Comando padrão: roda Puma em dev ou Thruster em prod
CMD if [ "$RAILS_ENV" = "production" ]; then \
      ./bin/thrust ./bin/rails server -b 0.0.0.0 -p $PORT; \
    else \
      ./bin/rails server -b 0.0.0.0 -p $PORT; \
    fi