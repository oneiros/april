class LineItem < ActiveRecord::Base

  belongs_to :invoice

  validates_presence_of :quantity, :unit, :description, :unit_price

end
