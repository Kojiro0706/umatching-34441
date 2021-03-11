class BuildersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_builder, except: [:index, :new, :create]
  before_action :check_user, only:[:edit,:update,:destroy]

  def index
    @builders= Builder.all.includes(:user)
  end

  def new
    @builder= Builder.new
  end

  def create
    @builder= Builder.new(builder_params)
    if @builder.save
       redirect_to root_path
    else
       render :new
    end
  end

  def show
    @comment= Comment.new
    @comments= @builder.comments.includes(:user)
  end

  def edit
  end

  def update
    if @builder.update(builder_params)
       redirect_to builder_path
    else
       render :edit
    end
  end

  def destroy
    @builder.destroy
    redirect_to root_path
  end
  private
  def builder_params
    params.require(:builder).permit(:title,:description,:category_id,:place,:image).merge(user_id: current_user.id)
  end

  def set_builder
    @builder= Builder.find(params[:id])
  end

  def check_user
    if @builder.user_id != current_user.id
      redirect_to root_path
    end
  end
end
