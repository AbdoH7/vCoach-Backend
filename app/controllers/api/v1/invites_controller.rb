module Api
    module V1
      class InvitesController < ApplicationController
        def create
          authorize Invite
          invite = @current_user.invites.build(invite_params)
          if invite.valid?
              token = JsonWebToken.encode(user_id: @current_user.id, email: invite.email)
              invite.token = token
              invite.save
              InviteMailer.invite_email(invite.email, token, @current_user.full_name).deliver_later
              render json: { invite: InviteBlueprint.render_as_hash(invite) }, status: :created
          else
              render json: { errors: invite.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def index
          authorize Invite
          invites = policy_scope(Invite)
          render json: {invites: InviteBlueprint.render_as_hash(invites)}, status: 200
        end

        def show
          authorize Invite
          begin
            invite = policy_scope(Invite).find(invite_params[:id])
            render json: InviteBlueprint.render_as_hash(invite), status: 200
          rescue
            render json: { error: 'Invite not found' }, status: :not_found
          end
        end
  
        private
  
        def invite_params
          params.permit(:email, :id)
        end
      end
    end
  end
  