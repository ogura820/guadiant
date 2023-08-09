class FamiliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_family, only: %i[show edit  destroy]



  def index
    @families = current_user.families
    @family = Family.new

    if params[:sent_mail]
      StockMailer.stock_mail(current_user.calculate_stocks,@families.sum(&:coefficient),current_user).deliver
      redirect_to families_path, notice: 'メール送信しました'
    end
    
  end

  def update
    @family = Family.find(params[:id])
    if @family.update(family_params)
      redirect_to families_path, notice: "タスクを編集しました！"
    else
      render :edit
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

  private
    def set_family
      @family = Family.find(params[:id])
    end

    def family_params
      params.require(:family).permit(%i[name sex age diet pet])
    end
end
