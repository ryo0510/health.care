class CreateCourseResults < ActiveRecord::Migration[5.2]
  def change
    create_table :course_results do |t|
			t.integer :entry_id, null: false

      t.timestamps
    end
  end
end
