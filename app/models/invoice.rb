class Invoice < ActiveRecord::Base

  belongs_to :customer
  belongs_to :invoice_template_id

  has_many :line_items

  accepts_nested_attributes_for :line_items

  validates_presence_of :date, :number
  validates_uniqueness_of :number

end
