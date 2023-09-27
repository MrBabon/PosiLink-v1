class OrganizationsController < ApplicationController
  def index
    if params[:query]
      @organizations = Organization.search_by_organization(params[:query])
    else
      @organizations = Organization.all
    end
    params[:query] = ""

  end

  def follow
    @organization = Organization.find(params[:id])

    if current_user.follow(@organization)
      flash[:success] = "Vous suivez maintenant #{@organization.name}."
    else
      flash[:error] = "Le suivi de #{@organization.name} a échoué."
    end

    redirect_to organization_path(@organization)
  end

  def unfollow
    @organization = Organization.find(params[:id])

    if current_user.unfollow(@organization)
      flash[:success] = "Vous ne suivez plus #{@organization.name}."
    else
      flash[:error] = "Le désabonnement de #{@organization.name} a échoué."
    end

    redirect_to organization_path(@organization)
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
end
