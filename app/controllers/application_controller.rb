class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :guide, :notice]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

  # ログイン後の遷移先
  def after_sign_in_path_for(resource)
    themes_path
  end

  # ログアウト後の遷移先
  def after_sign_out_path_for(resource)
    homes_guide_path
  end
end
