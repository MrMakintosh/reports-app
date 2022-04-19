#frozen_string_literal: true

module Api
  class BaseController < ActionController::API
    respond_to :json

    %i[index new create edit update show destroy].each do |method_name|
      define_method method_name do
        raise I18n.t('errors.base.no_result') if @result.blank?

        render json: @result
      end
    end
  end
end