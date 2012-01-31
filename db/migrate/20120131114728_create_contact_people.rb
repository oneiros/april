class CreateContactPeople < ActiveRecord::Migration
  def change
    create_table :contact_people do |t|
      t.string :name
      t.integer :customer_id

      t.timestamps
    end
    add_column :invoices, :contact_person_id, :integer
  end
end
