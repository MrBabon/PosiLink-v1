class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    start_time = params.fetch(:start_time, Date.today).to_date
    @participations = Participation.where(start_time: start_time.beginning_of_month.beginning_of_week..start_time.end_of_month.end_of_week)

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
