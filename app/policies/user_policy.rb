class UserPolicy <ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.where(id:user.id) if doctor?
      raise Pundit::NotAuthorizedError, 'Unauthorized' if patient?
    end
  end

  def index?
    doctor?
  end

  def create?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    doctor? || user.id == record.id
  end

end
