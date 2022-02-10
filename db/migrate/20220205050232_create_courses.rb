class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.integer :category_id, null: false
    	t.string :name, null: false
    	t.text :working_item, null: false
    	t.integer :target_date, null: false
    	t.integer :way, null: false


      t.timestamps
    end
    add_reference :courses, :course_results, foreign_key: true
  end
end
