module Api
	module V1
		class AnnouncementsController < ApplicationController
			def create
				authorize Announcement
				announcement = @current_user.announcements.build(announcement_params)
				if announcement.valid?
					announcement.save
					render json: { announcement: AnnouncementBlueprint.render_as_hash(announcement) }, status: :created
				else
					render json: { errors: announcement.errors.full_messages }, status: :unprocessable_entity
				end
			end

			def index
				authorize Announcement
				announcements = policy_scope(Announcement)
				render json: { announcements: AnnouncementBlueprint.render_as_hash(announcements) }, status: 200
			end

			def show
				authorize Announcement
				announcement = policy_scope(Announcement).find(params[:id])
				render json: { announcement: AnnouncementBlueprint.render_as_hash(announcement) }, status: 200
			end

			def update
				authorize Announcement
				announcement = policy_scope(Announcement).find(params[:id])
				announcement.update(announcement_params)
				render json: { announcement: AnnouncementBlueprint.render_as_hash(announcement) }, status: 200
			end

			def destroy
				authorize Announcement
				announcement = policy_scope(Announcement).find(params[:id])
				announcement.destroy
				render json: { announcement: AnnouncementBlueprint.render_as_hash(announcement) }, status: 200
			end

			private

			def announcement_params
				params.permit(:content)
			end
		end
	end
end