class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.integer :category_id, null: false
    	t.string :name, null: false
    	t.text :working_item, null: false
    	t.text :working_item_second
    	t.text :working_item_third
    	t.integer :target_date, null: false
    	t.integer :way, null: false


      t.timestamps
    end
  end
end
