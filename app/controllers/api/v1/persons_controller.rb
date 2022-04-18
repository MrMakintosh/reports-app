module Api
  module V1
    class PersonsController < Api::BaseController
      def profile
        @active_request = [] ## array of requests in progress
        @new_request = [] ## array of new requests
        Request.all.each do |a|
          if a.allowed == 1 and a.complited == 0
            @active_request.push a
          elsif a.allowed == 0
            @new_request.push a
          end
        end
      end

      def index
        User.paginate(:page => params[:page], :per_page => params[:per_page])
      end

      def new
        User.new
      end

      def create
        Users::Creator.call(user_params)
      end

      def edit
        User.find(params[:id])
      end

      def update
        Users::Updater.call(params)
      end

      def destroy
        User.find(params[:id]).destroy
      end

      private

      def user_params
        params.require(:user).permit(:email, :phone, :password, :admin, :cabinet, :name, :surname)
      end
    end
  end
end