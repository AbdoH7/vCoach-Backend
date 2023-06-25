class Exercise < ApplicationRecord
    has_many :assignments 
    validates :name, presence: true, uniqueness: true
    validates :model_available, presence: true
    #validates :type, presence: true
    #validates :body_area, presence: true
    validates :instructions, presence: true
    validates :model_url, format: { with: URI::regexp(%w(http https)), message: "must be a valid url" }, uniqueness: true
    validates :video, format: { with: URI::regexp(%w(http https)), message: "must be a valid url" }, uniqueness: true

end
