# frozen_string_literal: true

module Api
  class BaseController < ActionController::API
    rescue_from Exception, with: :error_500
    rescue_from ActiveRecord::RecordNotFound, with: :error_404

    def error_500(e)
      logger.error("#{e.message}\n#{params.to_unsafe_h}\n#{e.backtrace.join("\n")}")
      render json: {}, status: :internal_server_error
    end

    def error_404
      render json: {}, status: :not_found
    end
  end
end
