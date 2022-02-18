class Public::PostMessagesController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @post_message = PostMessage.new
    @post_messages =  PostMessage.all.order(created_at: :desc).page(params[:page]).per(15)
  end

  def create
    @post_messages = PostMessage.all.order(created_at: :desc).page(params[:page]).per(15)
    @post_message = PostMessage.new(post_message_params)
    @post_message.customer_id = current_customer.id
    @post_message.save
  end

  def post_message_params
    params.require(:post_message).permit(:nickname, :message, :image)
  end

end
