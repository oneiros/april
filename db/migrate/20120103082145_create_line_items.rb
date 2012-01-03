class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :invoice_id
      t.decimal :quantity, :precision => 8, :scale => 2
      t.string :unit
      t.text :description
      t.decimal :unit_price, :precision => 8, :scale => 2
      t.decimal :vat, :precision => 4, :scale => 2

      t.timestamps
    end
  end
end
