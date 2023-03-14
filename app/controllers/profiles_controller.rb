class ProfilesController < ApplicationController
  def update
    current_user.update(user_params)
    if current_user.save
      redirect_to sub_path
    else
      @user = current_user
      @bookmarks = Bookmark.where(user: current_user).where(ticked: true).order(:priority)
      render "pages/list", status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:availability)
  end
end
