# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :authenticate_user!
  before_action :set_current_user
  
  private
  
  def authenticate_user!
    unless session[:user_id]
      redirect_to login_path, alert: 'Please log in to continue.'
    end
  end
  
  def set_current_user
    if session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
      unless @current_user
        session[:user_id] = nil
        redirect_to login_path, alert: 'Session expired. Please log in again.'
      end
    end
  end
  
  def authorize_admin!
    redirect_to dashboard_path, alert: 'Access denied.' unless @current_user&.role&.name == 'admin'
  end
  
  def authorize_teacher!
    redirect_to dashboard_path, alert: 'Access denied.' unless @current_user&.role&.name == 'teacher'
  end
  
  def authorize_student!
    redirect_to dashboard_path, alert: 'Access denied.' unless @current_user&.role&.name == 'student'
  end
end