class FollowsController < AuthController
  include Followable

  def create
    @follower = User.find(current_user.id)
    @followed = User.find(params[:id])
    if @follower.followings.exclude?(@followed) && (@follower != @followed)
      Follow.create!(follower: @follower, followed_user: @followed)
    end
    @can_follow = already_follow(@followed)
  end

  def destroy
    @followed = User.find(params[:id])
    @follow = Follow.find_by(follower: current_user, followed_user: @followed.id)
    @follow.destroy
    @can_follow = already_follow(@followed)
  end
end
