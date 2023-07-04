class CommentPolicy < ApplicationPolicy
	class Scope < Scope
		def resolve
			if(doctor?)
				user_ids = DoctorPatientAssignment.where(doctor_id: user.id).pluck(:patient_id)
				user_ids.push(user.id)
				return scope.where(user_id: user_ids)
			elsif(patient?)
				doctor_ids = DoctorPatientAssignment.where(patient_id: user.id).pluck(:doctor_id)
				user_ids = DoctorPatientAssignment.where(doctor_id: doctor_ids).pluck(:patient_id)
				doctor_ids.each do |doctor_id|
					user_ids.push(doctor_id)
				end
				user_ids.push(user.id)
				return scope.where(user_id: user_ids)
			end
		end
	end

	def create?
		doctor? || patient?
	end
	def update?
		doctor? || patient?
	end
	def destroy?
		doctor? || patient?
	end
end