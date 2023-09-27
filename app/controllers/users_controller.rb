class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :user, only: [:show, :edit, :update, :update_avatar, :my_events]

  def show
    @participations = Participation.where(user_id: @user.id).includes(:event)
    @participations_by_date = @participations.group_by { |p| p.event.start_time.to_date }
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: 'Profil mis à jour avec succès.'
    else
      render :edit
    end
  end

  def update_avatar
    if @user.update(user_avatar_params)
      redirect_to user_path, notice: 'Photo de profil mise à jour avec succès.'
    else
      render :show
    end
  end

  def my_events
    @participating_events = @user.events
  end

  def follow_organization
    user = User.find(params[:id])
    organization = Organization.find(params[:organization_id])
  
    if user.follow(organization)
      flash[:success] = "Vous suivez maintenant #{organization.name}."
    else
      flash[:error] = "Le suivi de #{organization.name} a échoué."
    end
  
    redirect_to organization_path(organization)
  end

  private

  def user
    @user = current_user
  end

  def user_avatar_params
    params.require(:user).permit(:avatar)
  end
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :avatar, :nickname)
  end
end
