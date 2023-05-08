module Api
    module V1
      class InvitesController < ApplicationController
        def create
          invite = @current_user.invites.build(invite_params)
          if invite.valid?
              token = JsonWebToken.encode(user_id: @current_user.id, email: invite.email)
              invite.token = token
              invite.save
              InviteMailer.invite_email(invite.email, token, @current_user.full_name).deliver_later
              render json: { invite: invite }, status: :created
          else
              render json: { errors: invite.errors.full_messages }, status: :unprocessable_entity
          end
        end
  
        private
  
        def invite_params
          params.permit(:email)
        end
      end
    end
  end
  