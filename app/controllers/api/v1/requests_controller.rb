module Api
  module V1
    class RequestsController < Api::BaseController
      def index
        @result = Requests::Indexer.call(params)
        super
      end

      def show
        @result = Request.find(params[:id])
        super
      end

      def new
        @result = Request.new
        super
      end

      def create
        @result = Requests::Creator.call(request_params)
        super
      end

      def edit
        @result = Request.find(params[:id])
        super
      end

      def update
        @result = Requests::Updator.call(params: request_params.merge(id: params[:id]), user: current_user)
        super
      end

      private

      def request_params
        params.require(:request).permit(:type_of_problem, :message, :allowed, :complited, :admin, :admin_message)
      end
    end
  end
end