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

	private

		def user_is_doctor
			errors.add(:user, "must be a doctor") unless user.user_type == "doctor"
		end
end