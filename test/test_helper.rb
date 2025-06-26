ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Ativa os métodos como `create(:user)`
  include FactoryBot::Syntax::Methods

  include Devise::Test::IntegrationHelpers

  # Adicione mais helpers para testes unitários aqui
end

class ActionDispatch::IntegrationTest
  # Para autenticação com Devise nos testes de integração
  include Devise::Test::IntegrationHelpers

  def login_user(user = users(:one))
    sign_in user
  end
end
