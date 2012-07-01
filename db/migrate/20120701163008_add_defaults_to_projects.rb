class AddDefaultsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :default_vat, :decimal, :precision => 4, :scale => 2
    add_column :projects, :default_rate, :decimal, :precision => 8, :scale => 2
  end
end
