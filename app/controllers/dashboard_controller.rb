class DashboardController < AuthController
  def index
    @posts = Post.includes(:user)
  end
end
