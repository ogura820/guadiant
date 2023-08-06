class FamiliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_family, only: %i[ show edit  destroy ]

  def index
    @families = current_user.families
    @family = Family.new
    @coefficient = @families.sum(&:coefficient)
    @required_stock = current_user.calculate_stocks
    #Userモデルに備蓄算出ロジックあり

    if params[:sent_mail]
      StockMailer.stock_mail(@required_stock,@coefficient,current_user).deliver
      redirect_to families_path, notice: 'メール送信しました'
    end
    
  end

  def update
    @family = Family.find(params[:id])
    if @family.update(family_params)
      redirect_to familys_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def new
    @family = Family.new
  end

  def create
    @family = current_user.families.build(family_params)

    respond_to do |format|
      if @family.save
        format.html { redirect_to families_url, notice: "算出用ユーザー作成に成功しました" }
      else
        @families = Family.all 
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @family.destroy
    respond_to do |format|
      format.html { redirect_to families_url, notice: "算出用ユーザーの削除に成功しました" }
    end
  end

  private
    def set_family
      @family = Family.find(params[:id])
    end

    def family_params
      params.require(:family).permit(:name, :sex, :age, :diet, :pet)
    end

end
