class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    def home_page
      if user_signed_in?
        redirect_to games_path
      end
    end

    def go_log_in 
      flash[:alert] = "Please log in!"
      redirect_to root_path
    end 

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end
end
