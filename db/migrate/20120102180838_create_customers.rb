class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :handle
      t.string :name
      t.string :address_line_1
      t.string :address_line_2
      t.string :zip
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
