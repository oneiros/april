class Customer < ActiveRecord::Base

  has_many :invoices
  has_many :projects
  has_many :time_entries, :through => :projects

  accepts_nested_attributes_for :projects

  validates_presence_of :handle, :name, :address_line_1, :city, :zip
  validates_uniqueness_of :handle

end
