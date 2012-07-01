class AddInvoiceIdToTimeEntries < ActiveRecord::Migration
  def change
    add_column :time_entries, :invoice_id, :integer
  end
end
