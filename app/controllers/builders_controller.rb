class BuildersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_builder, except: [:index, :new, :create,:search]
  before_action :check_user, only:[:edit,:update,:destroy]
  before_action :search_builder,only:[:index,:search]

  def index
    @builders= Builder.order(created_at: :desc).includes(:user)
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

  def search
    @results=@q.result
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
  
  def search_builder
    @q=Builder.ransack(params[:q])
  end
end
