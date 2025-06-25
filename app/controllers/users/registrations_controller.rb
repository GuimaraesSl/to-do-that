# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [ :create ]
  before_action :configure_account_update_params, only: [ :update ]

  protected

  # Permite o parâmetro full_name no cadastro (sign up)
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :full_name ])
  end

  # Permite o parâmetro full_name na atualização do perfil (account update)
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [ :full_name ])
  end
end
