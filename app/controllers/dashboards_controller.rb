class DashboardsController < ApplicationController

  respond_to :html

  before_filter :authenticate_user!

  def show
    @gmaps_json = User.where(active: true).to_gmaps4rails
  end

  def update
    current_user.update_attributes params[:user]
    respond_with current_user, location: dashboard_path
  end

end

