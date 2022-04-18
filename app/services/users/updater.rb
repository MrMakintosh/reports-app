module Users
  class Updater < Base
    def initialize(params = {})
      @user = User.find(params[:id])
    end

    def call
      return not_saved(@user.errors.full_messages) unless @user.update(params[:user])

      @user
    end
  end
end