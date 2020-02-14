# frozen_string_literal: true

class AuthController < ApplicationController
  layout 'dashboard'
  before_action :authenticate_user!
end