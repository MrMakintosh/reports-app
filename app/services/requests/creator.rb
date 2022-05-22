# frozen_string_literal: true

module Requests
  class Creator < ApplicationService
    def initialize(params={})
      @user = params[:user]
      @params = params.except(:user)
    end

    def call
      request = @user.requests.new(@params)
      Telegramer::Notificator.call(@user) if request.save
      return not_saved(key: :requests, errors: request.errors.full_messages) if request.errors.any?

      request
    end
  end
end