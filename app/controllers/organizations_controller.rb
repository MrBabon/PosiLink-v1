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
end
