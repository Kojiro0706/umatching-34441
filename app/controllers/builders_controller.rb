class BuildersController < ApplicationController
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
  
  private
  def builder_params
    params.require(:builder).permit(:title,:description,:category_id,:place,:image).merge(user_id: current_user.id)
  end
end
