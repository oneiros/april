class CreateInvoiceTemplates < ActiveRecord::Migration
  def change
    create_table :invoice_templates do |t|
      t.string :paper_size
      t.text :header
      t.string :address_line
      t.string :city
      t.text :footer_left
      t.text :footer_middle
      t.text :footer_right

      t.timestamps
    end
  end
end
