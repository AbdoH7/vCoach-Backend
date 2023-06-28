class UserPolicy <ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.where(id:user.id) 
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
    true
  end

end
