class StockpilesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_stockpile, only: %i[ show edit  destroy update]

  def index
    @stockpiles = current_user.stockpiles
    @stockpile = Stockpile.new
  end

  def update
    if @stockpile.update(stockpile_params)
      redirect_to stockpiles_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def create
    @stockpile = current_user.stockpiles.build(stockpile_params)

    respond_to do |format|
      if @stockpile.save
        format.html { redirect_to stockpiles_url, notice: "登録できました" }
      else
        @stockpiles = Stockpile.all 
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @stockpile.destroy
    respond_to do |format|
      format.html { redirect_to stockpiles_url, notice: "削除できました" }
    end
  end

  private
    def set_stockpile
      @stockpile = Stockpile.find(params[:id])
    end

    def stockpile_params
      params.require(:stockpile).permit(:name, :expiry_on, :notice_on)
    end
end
