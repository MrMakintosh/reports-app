# frozen_string_literal: true

module Users
  class Creator < ApplicationService
    def initialize(params = {})
      @user = User.new(params)
    end

    def call
      return not_saved(key: :users, errors: @user.errors.full_messages) unless @user.save

      @user
    end
  end
end