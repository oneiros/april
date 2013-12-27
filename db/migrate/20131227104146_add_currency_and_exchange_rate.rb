class AddCurrencyAndExchangeRate < ActiveRecord::Migration
  def change
    add_column :invoice_templates, :currency, :string, default: 'EUR'
    add_column :invoices, :exchange_rate, :decimal, default: 1, precision: 6, scale: 2
  end
end
