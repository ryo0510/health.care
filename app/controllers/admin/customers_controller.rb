class Admin::CustomersController < ApplicationController
  before_action :ensure_customer

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer)
    else
      redirect_to request.referer
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :first_name_kana, :last_name_kana, :email, :address, :tel, :is_deleted)
  end

  def ensure_customer
    @customer = Customer.find(params[:id])
  end
end
