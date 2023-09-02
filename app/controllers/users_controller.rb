class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @participations = @user.participations.includes(:event)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path, notice: 'Profil mis à jour avec succès.'
    else
      render :edit
    end
  end

  def update_avatar
    @user = current_user
    if @user.update(user_avatar_params)
      redirect_to user_path, notice: 'Photo de profil mise à jour avec succès.'
    else
      render :show
    end
  end

  private

  def user_avatar_params
    params.require(:user).permit(:avatar)
  end
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :avatar, :nickname)
  end
end
