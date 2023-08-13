class DashboardController < ApplicationController
  def index
    if user_signed_in?
      @maps = current_user.maps
      @families = current_user.families.preload(:user)
      @stockpiles = current_user.stockpiles
    end
  end
end
