class AddFileToInvoiceTemplates < ActiveRecord::Migration
  def change
    add_column :invoice_templates, :file, :string
  end
end
