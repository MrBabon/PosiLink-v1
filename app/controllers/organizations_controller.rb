class OrganizationsController < ApplicationController


  def index
    if params[:query]
      @organizations = Organization.search_by_organization(params[:query])
    else
      @organizations = Organization.all
    end
    params[:query] = ""

  end

  def show
      @organization = Organization.find(params[:id])
      @events = @organization.events
      @markers = @events.geocoded.map do |event|
        {
          lat: event.latitude,
          lng: event.longitude,
          info_window_html: render_to_string(partial: "info_window", locals: {event: event})
        }
      end
  end

  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def new
    @organization = Organization.new
  end

  def follow
    @organization = Organization.find(params[:id])

    if current_user.follow(@organization)
      flash[:notice] = "Vous suivez maintenant #{@organization.name}."
    else
      flash[:notice] = "Le suivi de #{@organization.name} a échoué."
    end

    redirect_to organization_path(@organization)
  end

  def unfollow
    @organization = Organization.find(params[:id])

    if current_user.unfollow(@organization)
      flash[:notice] = "Vous ne suivez plus #{@organization.name}."
    else
      flash[:notice] = "Le désabonnement de #{@organization.name} a échoué."
    end

    redirect_to organization_path(@organization)
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :address, :phone_number, :description, :picture)
  end

end
