module Followable
  extend ActiveSupport::Concern

  def already_follow(user)
    @can_follow = if user.followers.include?(current_user)
                    false
                  else
                    true
                  end
  end
end