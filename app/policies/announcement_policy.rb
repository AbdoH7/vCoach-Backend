class AnnouncementPolicy < ApplicationPolicy
	class Scope < Scope
		def resolve
			return scope.where(user_id: user.id) if doctor?
			if patient?
				user_ids = DoctorPatientAssignment.where(patient_id: user.id).pluck(:doctor_id)
				return scope.where(id: user_ids)
			end
		end
	end
	
	def index?
		doctor? || patient?
	end
	
	def create?
		doctor?
	end
	
	def show?
		doctor? || patient?
	end
	
	def update?
		doctor?
	end
	
	def destroy?
		doctor?
	end
end