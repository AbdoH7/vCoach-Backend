class AssignmentPolicy <ApplicationPolicy
    class Scope < Scope
      def resolve
        return scope.where(doctor_id:user.id) if doctor?
        return scope.where(patient_id:user.id) if patient?
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
      patient? || doctor?
    end

    def destroy?
    	doctor?
    end

		def doctor_update?
			doctor?
		end
  end
  