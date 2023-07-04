class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :announcement
	validates :content, presence: true
	validates :user_id, presence: true    

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

		def pluralize(value, singular)
			value = value.round
			"#{value} #{singular}#{'s' unless value == 1}"
		end
end