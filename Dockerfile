# syntax=docker/dockerfile:1

ARG RUBY_VERSION=3.4.4
FROM ruby:${RUBY_VERSION}-slim AS base

WORKDIR /rails

# Variáveis de ambiente globais
ENV BUNDLE_PATH="/usr/local/bundle" \
    PATH="/usr/local/bundle/bin:$PATH" \
    RAILS_ENV="production"

# Instala pacotes básicos para produção
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl libjemalloc2 libvips postgresql-client nodejs && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Etapa de build das dependências e precompilação
FROM base AS build

# Instala dependências de build
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential libpq-dev libyaml-dev pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copia arquivos do bundle e instala as gems
COPY Gemfile Gemfile.lock ./
RUN bundle config set without 'development test' && \
    bundle install --deployment && \
    bundle exec bootsnap precompile --gemfile

# Copia o restante do app
COPY . .

# Garante permissões corretas e precompila assets
RUN chmod +x ./bin/* && \
    SECRET_KEY_BASE=dummydummydummydummydummydummydummydummy ./bin/rails assets:precompile

# Etapa final (imagem de execução)
FROM base AS final

# Reaplica variáveis de ambiente
ENV BUNDLE_PATH="/usr/local/bundle" \
    PATH="/usr/local/bundle/bin:$PATH" \
    RAILS_ENV="production"

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

# Comando padrão: roda Puma em produção
CMD ["./bin/rails", "server", "-b", "0.0.0.0", "-p", "$PORT"]