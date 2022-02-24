# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :check_customer, only: [:create, :guest_sign_in]
  before_action :customer_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to root_path, notice: 'ゲストでログインしました。'
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

  def check_customer # 複数のモデルで同時にログイン出来ないようにチェックするメソッド
    if current_admin
      flash[:alert] = '管理者として既にログインしています。ログアウトしてください。'
      redirect_to root_path
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_in_path_for(_resource)
    root_path
  end

  def customer_state # 退会しているかを判断するメソッド
    @customer = Customer.find_by(email: params[:customer][:email]) ##入力されたemailからアカウントを1件取得
    return if !@customer ## アカウントを取得できなかった場合、このメソッドを終了する
    if (@customer.valid_password?(params[:customer][:password])) && (@customer.is_deleted == true)
      flash[:alert] = "このアカウントは退会済みです。新規登録を行ってください。"
      redirect_to new_customer_registration_path
    end
  end
end
