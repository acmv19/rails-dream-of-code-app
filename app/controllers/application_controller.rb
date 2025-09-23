class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  # Method to restrict routes to admins only
   def require_admin
    if session[:role] != 'admin'
      flash[:alert] = 'You do not have access to that page'
      redirect_to root_path
    end
  end

  # Student only
  def require_student
    if session[:role] != 'student'
      flash[:alert] = 'Only students can perform this action'
      redirect_to root_path
    end
  end

  # Mentor only
  def require_mentor
    if session[:role] != 'mentor'
      flash[:alert] = 'Only mentors can perform this action'
      redirect_to root_path
    end
  end

  # Helper to get current user easily
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user

end
