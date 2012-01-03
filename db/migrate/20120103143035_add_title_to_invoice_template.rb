class AddTitleToInvoiceTemplate < ActiveRecord::Migration
  def change
    add_column :invoice_templates, :title, :string
  end
end
