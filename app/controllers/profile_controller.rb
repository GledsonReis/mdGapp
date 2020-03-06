# frozen_string_literal: true

class ProfileController < AuthController
  include Followable

  def index
    @user = User.find(params[:id])
    @can_follow = already_follow(@user)
  end
end
