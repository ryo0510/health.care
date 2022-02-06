class Admin::HomesController < ApplicationController
  def top
    @customers = Customer.page(params[:page]).per(10)
  end
end
