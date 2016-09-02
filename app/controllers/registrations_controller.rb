class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :set_minimum_password_length

  private
  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :institution)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :institution)
  end

  def update_resource(resource, params)
    if params[:password].present? && params[:current_password].present?
      resource.update_with_password(params)
    else
      resource.update_without_password(params.reject { |k, v| %w(password password_confirmation current_password).include? k })
    end
  end
end