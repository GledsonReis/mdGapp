# frozen_string_literal: true

# chatroom
class ChatroomsController < AuthController
  before_action :set_chatroom, only: %i[show edit update destroy]

  def index
    @chatrooms = Chatroom.all
    @new_chatroom = Chatroom.new
  end

  def show; end

  def create; end

  private
  def set_chatroom
    @chatroom = Chatroom.find(params[:id])
  end
end
