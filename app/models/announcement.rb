class Announcement < ApplicationRecord

	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy
	
	validates :content, presence: true

	validate :user_is_doctor
	
  
	def likes_count
		likes.count
	end

	def comments_count
		comments.count
	end

	def user_name
		user.full_name
	end

	def time_passed
		time_difference = Time.now - created_at
	
		if time_difference < 1.minute
		  "just now"
		elsif time_difference < 1.hour
		  pluralize(time_difference / 1.minute, "minute")
		elsif time_difference < 1.day
		  pluralize(time_difference / 1.hour, "hour")
		elsif time_difference < 7.days
		  pluralize(time_difference / 1.day, "day")
		else
		  created_at.strftime("%d %b %Y")
		end
	end

	private

		def user_is_doctor
			errors.add(:user, "must be a doctor") unless user.user_type == "doctor"
		end

		def pluralize(value, singular)
			value = value.round
			"#{value} #{singular}#{'s' unless value == 1}"
		end
end