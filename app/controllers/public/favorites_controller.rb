class Public::FavoritesController < ApplicationController
  def create
    @post_message = PostMessage.find(params[:post_message_id])
    favorite = @post_message.favorites.new(customer_id: current_customer.id)
    favorite.save
  end

  def destroy
    @post_message = PostMessage.find(params[:post_message_id])
    favorite = @post_message.favorites.find_by(customer_id: current_customer.id)
    favorite.destroy
  end
end
