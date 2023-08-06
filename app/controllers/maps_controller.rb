class MapsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_map, only: %i[show edit  destroy]

  def index
    @maps = current_user.maps
    @map = Map.new
  end

  def show
  end

  def create
    @map = current_user.maps.build(map_params)
      if @map.save
        redirect_to maps_url, notice: "避難場所を登録しました"
      else
        @maps = Map.all 
        render :index, status: :unprocessable_entity
      end
  end

  def destroy
    @map.destroy!
      redirect_to maps_url, notice: "削除しました"
  end

  private
    def set_map
      @map = Map.find(params[:id])
    end

    def map_params
      params.require(:map).permit(%i[name latitude longitude])
    end
end
