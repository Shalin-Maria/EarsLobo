class ApplicationController < ActionController::Base
  include ActsAsTenant::ControllerExtensions
  
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :find_current_tenant, unless: :devise_controller?
  before_action :authenticate_user_with_redirect!

  def find_current_tenant
    if current_user && current_user.tenant
      set_current_tenant_by_subdomain(current_user, current_user.tenant.subdomain)
    elsif !devise_controller? || action_name != 'new'
      redirect_to new_user_session_path
    end
  end
  
  


  protected
  def authenticate_user_with_redirect!
    if current_user
      sign_in(current_user, event: :authentication)
    elsif !devise_controller? || action_name != 'new'
      redirect_to new_user_session_path
    end
  end
end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:fname, :lname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:fname, :lname])
  end

