module Users
  class Updater < ApplicationService
    def initialize(params = {})
      @user = User.find(params[:id])
    end

    def call
      return not_saved(key: :users, errors: @user.errors.full_messages) unless @user.update(params[:user])

      @user
    end
  end
end