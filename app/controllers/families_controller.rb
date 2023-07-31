class FamiliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_family, only: %i[ show edit  destroy ]

  def index
    @families = Family.all.where(user_id: current_user.id)
    @family = Family.new
    @total_required_rice = @families.sum(&:calculate_required_rice)
    #各家族の必要量を計算後、sum(合計)する
    if params[:sent_mail]
      StockMailer.stock_mail(current_user,@total_required_rice).deliver
      redirect_to families_path, notice: 'メール送信しました'
    end
  end

  def show
  end

  def new
    @family = Family.new
  end

  def create
    @family = current_user.families.build(family_params)

    respond_to do |format|
      if @family.save
        format.html { redirect_to families_url, notice: "family was successfully created." }
      else
        @families = Family.all 
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @family.destroy
    respond_to do |format|
      format.html { redirect_to families_url, notice: "family was successfully destroyed." }
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
