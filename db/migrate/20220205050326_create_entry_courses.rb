class CreateEntryCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :entry_courses do |t|
      t.integer :customer_id, null: false
			t.integer :course_id, null: false
			t.integer :quantity, null: false

      t.timestamps
    end
  end
end
