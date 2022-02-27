class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_current_customer
  before_action :ensure_guest_customer, only: [:edit]

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to customers_mypage_path, notice: "登録情報を更新しました"
    else
      render "edit"
    end
  end

  def unsubscribe
  end

    #退会処理
  def withdraw
    @customer.update(is_deleted: true) 
    reset_session #ページ遷移しても以前入力した情報を保持することができる機能のことをsessionという
    redirect_to root_path, notice: "退会処理が完了しました"
  end

  private

  def set_current_customer
    @customer = current_customer
  end

  def ensure_guest_customer
    @customer = current_customer
    redirect_to customers_mypage_path, alert: 'ゲストユーザーはプロフィール編集画面へ遷移できません。' if @customer.email == "guest@example.com"
  end

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :tel, :address, :is_deleted)
  end

end
