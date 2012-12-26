class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!

  helper_method :current_project
  def current_project
    project = Project.find(session[:project_id]) rescue Project.last
  end

  def redirect_if_not_current_user(user_id)
    if user_id && user_id != current_user.id
      sign_out(current_user)
      redirect_to new_user_session_path
      return true
    end
    false
  end
end
