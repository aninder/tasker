class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.date :start_date
      t.date :finish_date
      t.boolean :completed, :default => false

      t.timestamps null: false
    end
  end
end
