class CreatePostMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :post_messages do |t|
      t.integer :customer_id, null: false
    	t.text :message, null: false
    	t.string :nickname, null: false
    	t.string :image_id
    	
      t.timestamps
    end
  end
end
