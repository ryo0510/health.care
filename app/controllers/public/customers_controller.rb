class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customers_mypage_path, notice: "登録情報を更新しました"
    else
      flash.now[:alert] = "空欄があります。入力内容をご確認ください"
      render "edit"
    end
  end
    
  def unsubscribe
    @customer = current_customer
  end
  
    #退会処理
  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true) #falseからtrueにupdate
    reset_session #ページ遷移しても以前入力した情報を保持することができる機能のことをsessionという
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :family_name_kana, :last_name_kana, :age, :image, :is_deleted)
  end

end
