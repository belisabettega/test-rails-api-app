class Api::V1::BaseController < ActionController::Base
    include Pundit::Authorization
    after_action :verify_authorized, except: :index
    after_action :verify_policy_scoped, only: :index
    protect_from_forgery with: :null_session

    rescue_from StandardError, with: :internal_server_error
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    private

    def user_not_authorized(exception)
        render json: { error: "Unauthorized action" }, status: :unauthorized
    end

    def not_found(exception)
        render json: { error: exception.message }, status: :not_found
    end

    def internal_server_error(exception)
        render json: { error: "Internal Server Error" }, status: :internal_server_error
    end
end