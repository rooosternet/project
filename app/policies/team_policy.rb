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

  def archive?
    valid? && !@team.backet?
  end

  def update_teams_order?
    user_signed_in?
  end

  private

  def valid?
    @current_user.admin? ||
    (@current_user.id == @team.owner_id) ||
    (@current_user.profile.teams.ids.include? @team.id)
  end
end
