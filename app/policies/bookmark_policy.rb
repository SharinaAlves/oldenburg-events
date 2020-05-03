class BookmarkPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user
  end

  def create?
    user
  end

  def destroy?
    user
  end
end
