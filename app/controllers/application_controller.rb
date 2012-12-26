class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!

  helper_method :current_project
  def current_project
    project = Project.find(session[:project_id]) rescue Project.last
  end
end
