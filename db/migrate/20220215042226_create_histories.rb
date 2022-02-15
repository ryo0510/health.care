class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.integer :customer_id, null: false
      t.integer :course_result_id, null: false
      t.string :result, null: false
			t.string :memo
			t.datetime :start_time, null: false

      t.timestamps
    end
  end
end
