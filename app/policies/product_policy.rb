class ProductPolicy < ApplicationPolicy
  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def delete?
    user.admin?
  end
end
