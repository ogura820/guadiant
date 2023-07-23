class FamiliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_family, only: %i[ show edit  destroy ]

  def index
    @families = Family.all.where(user_id: current_user.id)
    @family = Family.new
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
