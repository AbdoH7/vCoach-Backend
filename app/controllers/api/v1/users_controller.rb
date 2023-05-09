module Api
  module V1
    class UsersController < ApplicationController
    

      skip_before_action :authenticate_user, only: [:create, :login]
  
      def index
        authorize User
        #users = UserPolicy::Scope.new(@current_user, User).resolve
        users = policy_scope(User)
        render json: {users: UserBlueprint.render_as_hash(users)}, status: 200
      end
  
      def show
        authorize User
        begin
          user = policy_scope(User).find(user_params[:id])
          render json: UserBlueprint.render_as_hash(user), status: 200
        rescue ActiveRecord::RecordNotFound
          render json: { error: 'User not found' }, status: :not_found
        end
      end
  
      def create
        @user = User.new(user_params)
        if @user.save
          token = JsonWebToken.encode(user_id: @user.id)
          if (user_params[:user_type]=='patient' && invite_param)
            doc_id=Invite.find_by(token:invite_param).user_id
            @assignment = DoctorPatientAssignment.new(doctor_id:doc_id, patient_id:@user.id)
            if @assignment.save
              render json: {user: UserBlueprint.render_as_hash(@user) ,token: token, doctor_id: doc_id}, status: :created
            else
              render json: {user: UserBlueprint.render_as_hash(@user) ,token: token ,assignment_errors: @assignment.errors.full_messages}, status: :created
            end
          end

        else
          render json: {erors: @user.errors.full_messages}, status: 503
        end
      end
  
      def login
        @user = User.find_by_email(downcase_email)
        if @user&.authenticate(user_params[:password])
          token = JsonWebToken.encode(user_id: @user.id)
          time = Time.now + 24.hours.to_i
          render json: { user: UserBlueprint.render_as_hash(@user) ,token: token, exp: time.strftime("%m-%d-%Y %H:%M")}, status: :ok
        else
          render json: { error: 'Wrong email or password' }, status: :unauthorized
        end
      end

      private
      def user_params
        params.permit(:id, :user_type, :email, :password, :first_name, :last_name, :DOB, :phone_number)
      end

      def invite_param
        params.permit(:invite_token)[:invite_token]
      end

      def downcase_email
        user_params[:email].downcase
      end

    end
  end
end
