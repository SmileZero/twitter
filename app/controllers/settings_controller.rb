class SettingsController < ApplicationController
  before_action :set_user
  def info
  	@recognize_update = "info"
  end

  def avatar
  	@recognize_update = "avatar"
  end

  def updateAvatar
  	if @user.update_attribute(:avatar, settings_params[:avatar])
  		redirect_to settings_avatar_path,notice:"Update Photo Successfully"
  	else
  		render "avatar"
  	end
  end

  def updateInfo
  	if @user.update(settings_params)
  		redirect_to settings_info_path,notice:"Update Information Successfully"
  	else
  		render "info"
  	end
  end

private
  def set_user
  	@user = current_user
  end
  def settings_params
	 params.require(:user).permit(:name, :email, :avatar, :password, :password_confirmation)
  end
end
