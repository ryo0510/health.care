class Public::PostMessagesController < ApplicationController
  def index
    @post_message = PostMessage.new
    @post_messages = PostMessage.all
  end

  def create
    @post_message = PostMessage.new(post_message_params)
    @post_message.customer_id = current_customer.id
    @post_message.save
    redirect_to post_messages_path
  end

  def post_message_params
    params.require(:post_message).permit(:nickname, :message)
  end

end
