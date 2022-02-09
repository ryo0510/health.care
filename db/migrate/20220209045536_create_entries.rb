class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.integer :customer_id, null: false
			t.integer :course_id, null: false

      t.timestamps
    end
  end
end
