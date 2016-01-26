class ProfileConnectsController < ApplicationController
  def index
  end

  def show
  end

  def destroy
	pc = ProfileConnect.find(params[:id])
    # authorize current_user
    pc.destroy
    redirect_to root_path(profile: true)
  end
end
