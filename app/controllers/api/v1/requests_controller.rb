module Api
  module V1
    class RequestsController < Api::BaseController
      def index
        @active_request = current_user.requests.paginate(:page => params[:page], :per_page => 10) ## Recieve active requests for current user
        @request = Request.paginate(:page => params[:page], :per_page => 10)
        @sorted_request = @request.sort_by { |r| r.complited }
      end

      def show
        Request.find(params[:id])
      end

      def new
        Request.new
      end

      def create
        request = current_user.requests.new(request_params)
        if request.save
          Telegramer::Notificator.call(current_user)
        else
          respond_to.html { redirect_to :action => :new, notice: @request.errors }
        end
      end

      def edit
        Request.find(params[:id])
      end

      def update
        @request = Request.find(params[:id])
        ## When button 'Взять' clicked
        if @request.allowed == 0
          unless @request.update_attribute(:allowed, 1) && @request.update_attribute(:admin, current_user.name + ' ' + current_user.surname)
            @request.errors
          else
            @request
          end
        end

        ## When button 'Выполнено' clicked
        if @request.allowed == 1 && @request.complited == 0
          @request.update_attribute(:complited, 1) and @request.update_attributes(request_params)
          @request
        else
          @request.errors
        end
      end

      private

      def request_params
        params.require(:request).permit(:type_of_problem, :message, :allowed, :complited, :admin, :admin_message)
      end
    end
  end
end