class InvitePolicy <ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.where(user_id:user.id) if doctor?
      raise Pundit::NotAuthorizedError, 'unauthorized' if patient?
    end
  end

  def index?
    doctor?
  end

  def create?
    doctor?
  end

  def show?
    doctor?
  end
end
