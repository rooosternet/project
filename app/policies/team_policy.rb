class TeamPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @team = model
  end

  def index?
    @current_user.admin?
  end

  def edit?
    valid?
  end

  def show?
    valid?
  end

  def update?
    valid?
  end
  
  def destroy?
    valid?
  end

  private

  def valid?
    @current_user.admin? || (@current_user.id == @team.owner_id)
  end
end
