class Admin::CustomersController < ApplicationController
  before_action :ensure_customer
  before_action :ensure_guest_customer, only: [:edit]
  before_action :authenticate_admin!

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer)
    else
      flash.now[:alert] = "入力内容をご確認ください"
      render "edit"
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :first_name_kana, :last_name_kana, :email, :address, :tel, :is_deleted)
  end

  def ensure_customer
    @customer = Customer.find(params[:id])
  end

  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.email == "guest@example.com"
      redirect_to admin_customer_path(@customer) , alert: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end
