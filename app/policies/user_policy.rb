class UserPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def index?
    @current_user.admin?
  end

  def edit?
    @current_user.admin?
  end

  def show?
    @current_user.admin? #or @current_user == @user
  end

  def accepting_invitation?
    @current_user == @user
  end

  def update?
    @current_user.admin?
  end

  def update_profile_image?
    @current_user == @user
  end

  def update_avatars?
    @current_user == @user
  end

  def batch_invite?
    @current_user
  end

  def destroy?
    return false if @current_user == @user
    @current_user.admin?
  end

end
