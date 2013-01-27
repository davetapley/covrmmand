class DashboardsController < ApplicationController

  respond_to :html

  before_filter :authenticate_user!

  def show
    @gmaps_json = User.where(active: true).to_gmaps4rails do |user, marker|
      marker.picture( rich_marker: "<div style='background-color:white'><h1>#{ user.level }</h1>#{ user.name }</div>" )
    end
  end

  def update
    current_user.update_attributes params[:user]
    respond_with current_user, location: dashboard_path
  end

end

