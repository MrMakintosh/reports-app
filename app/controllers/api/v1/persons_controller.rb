# frozen_string_literal: true

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
        @result = User.paginate(:page => params[:page], :per_page => params[:per_page])
        super
      end

      def new
        @result = User.new
        super
      end

      def create
        @result = Users::Creator.call(user_params)
        super
      end

      def edit
        @result = User.find(params[:id])
        super
      end

      def update
        @result = Users::Updater.call(params)
        super
      end

      def destroy
        @result = User.find(params[:id]).destroy
        super
      end

      private

      def user_params
        params.require(:user).permit(:email, :phone, :password, :admin, :cabinet, :name, :surname)
      end
    end
  end
end