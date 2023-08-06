class MapsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_map, only: %i[ show edit  destroy ]

  def index
    @maps = current_user.maps
    @map = Map.new
  end

  def show
  end

  def create
    @map = current_user.maps.build(map_params)
    respond_to do |format|
      if @map.save
        format.html { redirect_to maps_url, notice: "Map was successfully created." }
      else
        @maps = Map.all 
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @map.destroy
    respond_to do |format|
      format.html { redirect_to maps_url, notice: "Map was successfully destroyed." }
    end
  end

  private
    def set_map
      @map = Map.find(params[:id])
    end

    def map_params
      params.require(:map).permit(:name, :latitude, :longitude)
    end
end
