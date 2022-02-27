# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  before_action :check_admin, only: [:create, :guest_sign_in]
  # before_action :configure_sign_in_params, only: [:create]

  def guest_sign_in
    admin = Admin.guest
    sign_in admin
    redirect_to admin_top_path, notice: 'ゲストでログインしました。'
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def check_admin
    if current_customer
      flash[:alert] = 'ユーザーとして既にログインしています。ログアウトしてください。'
      redirect_to root_path
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_in_path_for(_resource)
    admin_top_path
  end

  def after_sign_out_path_for(_resource)
    root_path
  end
end
