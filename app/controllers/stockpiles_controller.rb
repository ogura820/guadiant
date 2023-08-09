class StockpilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_stockpile, only: %i[show edit destroy update]

  def index
    @q = current_user.stockpiles.ransack(params[:q])
    @stockpiles = @q.result(distinct: true)
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
      if @stockpile.save
        redirect_to stockpiles_url, notice: "登録できました"
      else
        @q = current_user.stockpiles.ransack(params[:q])
        @stockpiles = @q.result(distinct: true)
        render :index
      end
  end

  def destroy
    @stockpile.destroy!
      redirect_to stockpiles_url, notice: "削除できました"
  end

  private
  def set_stockpile
    @stockpile = Stockpile.find(params[:id])
  end

  def stockpile_params
    params.require(:stockpile).permit(%i[name expiry_on notice_on])
  end

end
