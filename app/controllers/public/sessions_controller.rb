# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :customer_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

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

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  protected

  def customer_state # 退会しているかを判断するメソッド
    @customer = Customer.find_by(email: params[:customer][:email]) ##入力されたemailからアカウントを1件取得
    return if !@customer ## アカウントを取得できなかった場合、このメソッドを終了する
    if (@customer.valid_password?(params[:customer][:password])) && (@customer.is_deleted == true)
      flash[:alert] = "このアカウントは退会済みです。新規登録を行ってください。"
      redirect_to new_customer_registration_path
    end
  end
end
