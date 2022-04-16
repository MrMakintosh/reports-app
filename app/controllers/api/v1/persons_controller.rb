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

      def menu
        User.paginate(:page => params[:page], :per_page => 5)
      end

      def index
        User.all
      end

      def new
        User.new
      end

      def create
        user = User.new(user_params)
        return not_saved(user) unless user.save

        user
      end

      def edit
        User.find(params[:id])
      end

      def update
        user = User.find(params[:id])
        return not_saved(user) unless user.update(user_params)

        user
      end

      def destroy
        User.find(params[:id]).destroy
      end

      private

      def user_params
        params.require(:user).permit(:email, :phone, :password, :admin, :cabinet, :name, :surname)
      end

      def not_saved(user)
        { error: t.errors.users.not_saved(user.errors.full_messages) }
      end
    end
  end
end