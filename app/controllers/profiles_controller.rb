class ProfilesController < ApplicationController
  def update
    current_user.update(user_params)
    if current_user.save
      redirect_to sub_path
    else
      render "/wishlist", status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:availability)
  end
end
