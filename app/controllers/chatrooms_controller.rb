# frozen_string_literal: true

# chatroom
class ChatroomsController < AuthController
  before_action :creating_new?, only: :create
  before_action :set_chatroom, only: %i[show edit update destroy]

  def index
    @chatrooms = Chatroom.all
    @new_chatroom = Chatroom.new
  end

  def show; end

  def create
    respond_to do |format|
      begin
        ActiveRecord::Base.transaction do
          @chatroom = Chatroom.create(name: set_chatroom_name)
          @user = User.find(params[:user_id])
          ChatroomUser.create(chatroom_id: @chatroom.id, user_id: @user.id)
          ChatroomUser.create(chatroom_id: @chatroom.id, user_id: current_user.id)
        end
        format.html { redirect_to chatroom_path(@chatroom), notice: 'Post was successfully destroyed.' }
      rescue StandardError => e
        format.html { render :index }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def set_chatroom
    @chatroom = Chatroom.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_chatroom_name
    set_user
    name = @user.username
    name
  end

  def creating_new?
    set_user
    chatrooms_user1 = Chatroom.joins(:users).where(users: {id: current_user.id})
    chatrooms_user2 = Chatroom.joins(:users).where(users: {id: @user.id})
    private_chat = (chatrooms_user1 & chatrooms_user2)
    if (private_chat.size == 1)
      redirect_to chatroom_path(private_chat.first)
    end
  end
end
