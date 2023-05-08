class Invite < ApplicationRecord
  belongs_to :user

  before_validation :downcase_email
  
  EMAIL_REGEX =  /\A([^-]+?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  
  validates :email, presence: true, format: { with: EMAIL_REGEX, message: "is not a valid email address" }
  validates :user, presence: true
  validates :user_type, inclusion: { in: ["doctor"], message: "must be a doctor" }

  private

  def user_type
    user&.user_type
  end

  def downcase_email
    self.email = email.downcase if email.present?
  end

end
