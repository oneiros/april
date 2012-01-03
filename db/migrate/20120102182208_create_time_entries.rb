class CreateTimeEntries < ActiveRecord::Migration
  def change
    create_table :time_entries do |t|
      t.integer :project_id
      t.decimal :duration, :precision => 5, :scale => 2
      t.string :comment
      t.date :date
      t.boolean :invoiced

      t.timestamps
    end
  end
end
