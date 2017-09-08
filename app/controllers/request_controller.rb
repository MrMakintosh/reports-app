class RequestController < ApplicationController
  respond_to :html

  def index
    @active_request = current_user.requests ## Recieve active requests for current user
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

  def update
    @request = Request.find(params[:id])
    if @request.update_attributes(require_params)
      redirect_to :action => :index
    else
      respond_to.html { redirect_to :action => :index, notice: @request.errors}
    end
  end

  private

  def request_params
    params.require(:request).permit(:type_of_problem, :message, :allowed, :complited, :admin)
  end
end
