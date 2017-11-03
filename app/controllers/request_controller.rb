class RequestController < ApplicationController
  respond_to :html

  def index
    @active_request = current_user.requests.paginate(:page => params[:page], :per_page => 5) ## Recieve active requests for current user
    @request = Request.paginate(:page => params[:page], :per_page => 5)
  end

  def show
    @request = Request.find(params[:id])
  end

  def new
    @request = Request.new
  end

  def create
    @user = current_user
    @request = @user.requests.new(request_params)
    if @request.save
      flash[:notice] = 'Ваша заявка успешно отправлена'
      redirect_to user_root_path
    else
      respond_to.html { redirect_to :action => :new, notice: @request.errors }
    end
  end

  def edit
    @request = Request.find(params[:id])
  end

  def update
    @request = Request.find(params[:id])
    ## When button 'Взять' clicked
    if @request.allowed == 0
      unless @request.update_attribute(:allowed, 1) && @request.update_attribute(:admin, current_user.name + ' ' + current_user.surname)
        redirect_to request_index_path, notice: @request.errors and return
      else
        redirect_to request_index_path, notice: 'Заявка успешно принята!' and return
      end
    end

    ## When button 'Выполнено' clicked
    if @request.allowed == 1 && @request.complited == 0
      @request.update_attribute(:complited, 1) and @request.update_attributes(request_params)
      redirect_to request_index_path, notice: 'Заявка успешно закрыта!' and return
    else
      redirect_to request_index_path, notice: @request.errors
    end
  end

  private

  def request_params
    params.require(:request).permit(:type_of_problem, :message, :allowed, :complited, :admin, :admin_message)
  end
end
