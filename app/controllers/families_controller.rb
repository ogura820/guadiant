class FamiliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_family, only: %i[edit  destroy]

  def index
    @families = current_user.families.preload(:user)
    @family = Family.new
  end

  def show
    @families = current_user.families.preload(:user)
    @coefficient = @families.sum(&:coefficient)
    @calculate_stocks = current_user.calculate_stocks
  end

  def update
    @family = Family.find(params[:id])
    if @family.update(family_params)
      redirect_to families_path, notice: "情報を更新しました！"
    else
      redirect_to families_path, notice: "更新に失敗しました。空白では更新できません"
    end
  end

  def new
    @family = Family.new
  end

  def create
    @family = current_user.families.build(family_params)
      if @family.save
        redirect_to families_url, notice: "算出用ユーザー作成に成功しました"
      else
        @families = current_user.families
        render :index
      end
  end

  def destroy
    @family.destroy!
    redirect_to families_url, notice: "算出用ユーザーの削除に成功しました"
  end

  def send_stock_mail
    @families = current_user.families.preload(:user)
    @coefficient = @families.sum(&:coefficient)
    @calculate_stocks = current_user.calculate_stocks
    
    StockMailer.stock_mail(@calculate_stocks, @coefficient, current_user).deliver
    redirect_to family_path, notice: 'メール送信しました'
  end

  private
    def set_family
      @family = Family.find(params[:id])
    end

    def family_params
      params.require(:family).permit(%i[name sex age diet pet])
    end
end
