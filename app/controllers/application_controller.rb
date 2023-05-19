require 'jwt'
class ApplicationController < ActionController::API
  include Pundit::Authorization
  before_action :validate_request, :authenticate_user, except: [:create, :login]
  rescue_from Pundit::NotAuthorizedError, with: :unauthorized

  # def authorize(record, query = nil)
  #   super(record, query, @current_user)
  # end

  def pundit_user
    @current_user
  end
  private

  def authenticate_user
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def validate_request
      render json: { error: 'Bad Request' }, status: :bad_request unless http_auth_header
  end

  def http_auth_header
    request.headers['Authorization']&.split(' ')&.last
  end

  def unauthorized
    render json: { error: "Unauthorized" }, status: :unauthorized
  end
end
