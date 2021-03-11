class UsersController < ApplicationController
  def show
    @user= User.find(params[:id])
    @builders= @user.builders
  end
end
