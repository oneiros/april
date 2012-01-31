class ChangeDefaultOfInvoiced < ActiveRecord::Migration
  def change
    change_column :time_entries, :invoiced, :boolean, :default => false 
  end
end
