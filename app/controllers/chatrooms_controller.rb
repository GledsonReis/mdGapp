# frozen_string_literal: true

# chatroom
class ChatroomsController < AuthController
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
          @chatroom = Chatroom.create(name: params[:chatroom][:name])
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

  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end
end
