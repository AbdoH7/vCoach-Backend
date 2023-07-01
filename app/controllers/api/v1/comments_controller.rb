module Api
	module V1
		class CommentsController < ApplicationController
			def create
				authorize Comment
				#Trigger NotFoundError if announcement isn't within scope or doesn't exist
				policy_scope(Announcement).find(params[:announcement_id])
				comment = @current_user.comments.build(comment_params)
				if comment.valid?
					comment.save
					render json: { comment: CommentBlueprint.render_as_hash(comment) }, status: :created
				else
					render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
				end
			end

			def update
				authorize Comment
				comment = policy_scope(Comment).find(params[:id])
				return render json: { errors: "You are not authorized to perform this action" }, status: :unauthorized unless comment.user_id == @current_user.id
				comment.update(update_params)
				render json: { comment: CommentBlueprint.render_as_hash(comment) }, status: 200
			end

			def destroy
				authorize Comment
				comment = policy_scope(Comment).find(params[:id])
				return render json: { errors: "You are not authorized to perform this action" }, status: :unauthorized unless comment.user_id == @current_user.id
				comment.destroy
				render json: { comment: CommentBlueprint.render_as_hash(comment) }, status: 200
			end

			private

			def comment_params
				params.permit(:content, :announcement_id)
			end

			def update_params
				params.permit(:content)
			end
		end
	end
end