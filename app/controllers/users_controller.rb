class UsersController < ActionController::Base

  def shops
    @shops = current_user.shops
  end

end