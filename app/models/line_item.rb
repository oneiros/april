class LineItem < ActiveRecord::Base

  belongs_to :invoice

  validates_presence_of :quantity, :unit, :description, :unit_price

  def total
    quantity * unit_price
  end

end
