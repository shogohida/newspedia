class Users::SessionsController < Devise::SessionsController
  def new_guest
    user = User.guest
    sign_in user
    #redirect_to root_path
    redirect_back(fallback_location: root_path, notice: "Logged in as a test user")
    # add AJAX?, redirect to somewhere else
  end
end
