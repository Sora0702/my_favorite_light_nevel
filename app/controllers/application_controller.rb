class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def ensure_normal_user
    if current_user.email == 'guest@example.com'
      flash[:notice] = "ゲストユーザーの編集はできません。"
      redirect_to root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :introduction, :image])
  end
end
