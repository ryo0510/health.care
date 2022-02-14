class CreateCourseResults < ActiveRecord::Migration[5.2]
  def change
    create_table :course_results do |t|
			t.integer :entry_id, null: false
			t.string :history
			t.string :memo
			t.datetime :start_time

      t.timestamps
    end

    add_reference :course_results, :entries, foreign_key: true
  end
end
