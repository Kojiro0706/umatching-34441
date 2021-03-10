class BuildersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @builders = Builder.all.includes(:user)
  end

  def new
    @builder =Builder.new
  end

  def create
    @builder =Builder.new(builder_params)
    if @builder.save
       redirect_to root_path
    else
       render :new
    end
  end
  def show
    @builder= Builder.find(params[:id])
  end

  def edit
    @builder= Builder.find(params[:id])
  end

  def update
    @builder= Builder.find(params[:id])
    if @builder.update(builder_params)
       redirect_to builder_path
    else
       render :edit
    end
  end
  private
  def builder_params
    params.require(:builder).permit(:title,:description,:category_id,:place,:image).merge(user_id: current_user.id)
  end
end
