class DashboardController < AuthController
  def index
    @posts = Post.includes(:user, :comments).order(created_at: :desc)
  end
end
