class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :announcement
	validates :content, presence: true
	validates :user_id, presence: true    

	def user_name
		user.full_name
	end
end