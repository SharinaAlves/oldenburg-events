class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      #scope.all
    end
  end

  def manifest?
    true
  end

  def service_worker
    true
  end
end
