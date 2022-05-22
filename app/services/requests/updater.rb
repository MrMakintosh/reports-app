# frozen_string_literal: true

module Requsets
  class Updater < ApplicationService
    def initialize(params: {}, user: nil)
      @params = params.except(:id)
      @user = user
      @request_id = params[:id]
    end

    def call
      return if (request = Request.find(@request_id)).blank?

      request.pick_by(user: @user) if request.ready_to_pick? && @user.present?
      request.complete(params: params)
      return not_saved(key: :requests, errors: request.errors.full_messages) if request.errors.any?

      request
    end
  end
end