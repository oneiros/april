class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :customer_id
      t.string :title
      t.decimal :time_budget

      t.timestamps
    end
  end
end
