class  DoctorPatientAssignmentPolicy<ApplicationPolicy
	class Scope < Scope
		def resolve
			if(doctor?)
				user_ids = DoctorPatientAssignment.where(doctor_id: user.id).pluck(:patient_id)
    		return User.where(id: user_ids)
			end
			if(patient?)
				user_ids = DoctorPatientAssignment.where(patient_id: user.id).pluck(:doctor_id)
				return User.where(id: user_ids)
			end
		end
	end

	def index?
		true
	end

	def create?
		patient?
	end
end
  