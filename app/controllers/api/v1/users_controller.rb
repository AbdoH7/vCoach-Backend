module Api
    module V1
        class UsersController < ApplicationController
        

            skip_before_action :authenticate_user, only: [:create, :login]
            before_action :find_user, only: [:show, :update, :destroy]
        
            def index
                users = User.all
                render json: {users: UserBlueprint.render_as_hash(users)}, status: 200
            end
        
            def show
                render json: UserBlueprint.render_as_hash(@user), status: 200
            end
        
            def create
                @user = User.new(user_params)
                if @user.save
                    token = JsonWebToken.encode(user_id: @user.id)
                    render json: {user: UserBlueprint.render_as_hash(@user) ,token: token}, status: :created
                else
                    render json: {erors: @user.errors.full_messages}, status: 503
                end
            end
        
            def login
                @user = User.find_by_email(params[:email])
                if @user&.authenticate(params[:password])
                  token = JsonWebToken.encode(user_id: @user.id)
                  time = Time.now + 24.hours.to_i
                  render json: { user: UserBlueprint.render_as_hash(@user) ,token: token, exp: time.strftime("%m-%d-%Y %H:%M")}, status: :ok
                else
                  render json: { error: 'unauthorized' }, status: :unauthorized
                end
            end
        
            private
            def user_params
            params.permit(:user_type, :email, :password, :first_name, :last_name, :DOB, :phone_number)
            end
        
            def find_user
            @user = User.find(params[:id])
            end
        
        end
    end
end
