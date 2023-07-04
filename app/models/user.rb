class User < ApplicationRecord
    before_validation :downcase_email, :downcase_type

    has_secure_password

    has_many :invites
    has_many :assignments_as_doctor, class_name: 'Assignment', foreign_key: 'doctor_id'
    has_many :assignments_as_patient, class_name: 'Assignment', foreign_key: 'patient_id'

    has_many :announcements, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :liked_announcements, through: :likes, source: :announcement
    
    mount_uploader :avatar, AvatarUploader

    EMAIL_REGEX =  /\A([^-]+?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    PASSWORD_REGEX = /\A(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^A-Za-z\d])(?!.*\s).*\z/
    TYPE_REGEX = /\A^(doctor|patient)$\Z/
    
    validates :email, format: { with: EMAIL_REGEX }, presence:true, uniqueness: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :password, format: { with: PASSWORD_REGEX }, presence: true
    validates :user_type, format: {with: TYPE_REGEX}, presence: true
    validates :phone_number, presence: true ,uniqueness: true 

    def full_name
        "#{first_name} #{last_name}"
    end

    private

    def downcase_email
        self.email = email.downcase if email.present?
        self.email = email.strip if email.present?
    end

    def downcase_type
        self.user_type = user_type.downcase if user_type.present?
    end

end
