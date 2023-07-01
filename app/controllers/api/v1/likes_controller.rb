module Api
	module V1
		class LikesController < ApplicationController
			def create
				authorize Like
				return render json: { errors: "You already liked this announcement" }, status: :unprocessable_entity if policy_scope(Like).where(user_id: @current_user.id, announcement_id: params[:announcement_id]).exists?
				like = @current_user.likes.build(like_params)
				#Trigger NotFoundError if announcement isn't within scope or doesn't exist
				policy_scope(Announcement).find(params[:announcement_id])
				if like.valid?
					like.save
					render json: { like: LikeBlueprint.render_as_hash(like) }, status: :created
				else
					render json: { errors: like.errors.full_messages }, status: :unprocessable_entity
				end
			end

			def destroy
				authorize Like
				like = policy_scope(Like).find(params[:id])
				return render json: { errors: "You are not authorized to perform this action" }, status: :unauthorized unless like.user_id == @current_user.id
				like.destroy
				render json: { like: LikeBlueprint.render_as_hash(like) }, status: 200
			end

			private

			def like_params
				params.permit(:announcement_id)
			end
		end
	end
end