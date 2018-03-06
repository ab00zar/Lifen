class CreateShifts < ActiveRecord::Migration[5.1]
  def change
    create_table :shifts do |t|
      t.integer :planning_id
      t.integer :worker_id
      t.string :start_date

      t.timestamps
    end
  end
end
