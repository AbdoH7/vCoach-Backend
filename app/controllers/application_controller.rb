require 'jwt'
class ApplicationController < ActionController::API
  include Pundit::Authorization
  before_action :validate_request, :authenticate_user
  rescue_from Pundit::NotAuthorizedError, with: :unauthorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  # def authorize(record, query = nil)
  #   super(record, query, @current_user)
  # end

  def pundit_user
    @current_user
  end

  def isDoctor?
    @current_user.user_type == 'doctor'
  end

  def isPatient?
    @current_user.user_type == 'patient'
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

  def not_found
    render json: { error: "Not Found" }, status: :not_found
  end
  
end
