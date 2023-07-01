class Like < ApplicationRecord
  belongs_to :user  
  belongs_to :announcement

	def user_name
		user.full_name
	end
end
    
    