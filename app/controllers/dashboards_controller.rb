class DashboardsController < ApplicationController

  respond_to :html

  before_filter :authenticate_user!

  def show
    @active_users = User.where(active: true, :location.exists => true)
    @gmaps_json = @active_users.to_gmaps4rails do |user, marker|
      marker.picture( rich_marker: "<div style='background-color:white; width: 150px'><h1>#{ user.level }</h1>#{ user.name }<br/>#{ view_context.time_ago_in_words user.location.timestamp } ago</div>" )
    end
  end

  def update
    current_user.update_attributes params[:user]
    respond_with current_user, location: dashboard_path
  end

end

