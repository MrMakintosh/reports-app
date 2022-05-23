# frozen_string_literal: true

module Requests
  class Indexer < ApplicationService
    def initialize(params = {})
      @page = params[:page]
      @per_page = params[:per_page]
    end

    def call
      Request.order(complited: :desc).paginate(page: @page, per_page: @per_page)
    end
  end
end