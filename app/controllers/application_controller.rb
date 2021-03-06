# frozen_string_literal: true

class ApplicationController < ActionController::Base
  layout 'auth', if: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    added_attrs = [:username, :email, :avatar, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  protected

  def after_sign_in_path_for(_resource)
    dashboard_index_path
  end
end
