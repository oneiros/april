class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :customer_id
      t.integer :invoice_template_id
      t.date :date
      t.string :number
      t.text :comment

      t.timestamps
    end
  end
end
