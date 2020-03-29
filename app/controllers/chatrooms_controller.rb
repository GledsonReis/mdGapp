# frozen_string_literal: true

# chatroom
class ChatroomsController < AuthController
  before_action :creating_new?, only: :create
  before_action :set_chatroom, only: %i[show edit update destroy]

  def index
    @chatrooms = Chatroom.joins(:users).includes(:users).where(users: { id: current_user.id })
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
        format.html { redirect_to chatroom_path(@chatroom), notice: 'Chatroom was successfully destroyed.' }
      rescue StandardError => e
        format.html { render :index }
        format.json { render json: @chatroom.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @chatroom.destroy
    respond_to do |format|
      format.html { redirect_to chatrooms_path, notice: 'Chatroom was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_chatroom
    begin
      @chatroom = Chatroom.find(params[:id])
      if @chatroom.present? && @chatroom.users.exclude?(current_user) 
        redirect_to not_authorized_path
      end
    rescue StandardError => e
      redirect_to not_found_path
    end
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
