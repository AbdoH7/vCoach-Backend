class Assignment < ApplicationRecord
    belongs_to :doctor, class_name: 'User', foreign_key: 'doctor_id'
    belongs_to :patient, class_name: 'User', foreign_key: 'patient_id'
		belongs_to :exercise
    
    # validations
    validates :doctor_id, presence: true
    validates :patient_id, presence: true
    validates :instructions, presence: true
    validates :instructions, format: { with: /\A{.*}\z/, message: "must be a valid object" }
    validate :validate_doctor_patient_types

    private

    def validate_doctor_patient_types
      errors.add(:doctor_id, "must be a doctor") unless doctor.user_type == "doctor"
      errors.add(:patient_id, "must be a patient") unless patient.user_type == "patient"
    end
end
