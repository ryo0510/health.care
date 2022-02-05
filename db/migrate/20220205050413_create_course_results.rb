class CreateCourseResults < ActiveRecord::Migration[5.2]
  def change
    create_table :course_results do |t|
      t.integer :customer_id, null: false
			t.integer :course_id, null: false
			t.string :record
			t.string :memo

      t.timestamps
    end
  end
end
