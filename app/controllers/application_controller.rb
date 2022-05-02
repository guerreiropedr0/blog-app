class ApplicationController < ActionController::Base
  def current_user
    @user = User.find_by(id: 1)
  end
end
