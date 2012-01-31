class AddDefaultCommentToInvoiceTemplates < ActiveRecord::Migration
  def change
    add_column :invoice_templates, :default_comment, :text
  end
end
