class PersonsController < ApplicationController

  def profile
  end

  def menu
    @user = User.paginate(:page => params[:page], :per_page => 5)
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
      redirect_to persons_menu_path, notice: 'Пользователь успешно зарегистрирован!'
    else
      respond_to.html { redirect_to persons_menu_path, notice: @user.errors }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to persons_menu_path, notice: 'Пользователь успешно изменен!'
    else
      respond_to.html { redirect_to persons_menu_path, notice: @user.errors }
    end
  end

  def destroy
    @user = User.find(params[:id])
    User.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to persons_menu_path, notice: @user.email + ' успешно удален.' }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :admin, :cabinet, :name, :surname)
  end
end
