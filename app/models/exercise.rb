class Exercise < ApplicationRecord
	has_many :assignments 

	validates :name, presence: true, uniqueness: true
	validates :instructions, presence: true
	validates :video, format: { with: URI::regexp(%w(http https)), message: "must be a valid URL" }, uniqueness: true, if: :video_present?
  validates :model_url, presence: true, format: { with: URI::regexp(%w(http https)), message: "must be a valid URL" }, uniqueness: true, if: :model_available?

	private

	def video_present?
    video.present?
  end

  def model_available?
    model_available == true
  end

end
