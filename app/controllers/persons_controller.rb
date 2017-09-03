class PersonsController < ApplicationController

  def profile
  end

  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to :action => :index
    else
      respond_to.html { redirect_to :action => :index, notice: @user.errors }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to :action => :index
    else
      respond_to.html { redirect_to :action => :index, notice: @user.errors }
    end
  end

  def destroy
    @user = User.find(params[:id])
    User.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: @user.email + ' успешно удален.' }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :group)
  end
end
