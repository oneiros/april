class Customer < ActiveRecord::Base

  has_many :invoices
  has_many :projects
  has_many :time_entries, :through => :projects
  has_many :contact_people

  accepts_nested_attributes_for :projects
  accepts_nested_attributes_for :contact_people

  validates_presence_of :handle, :name
  validates_uniqueness_of :handle

  scope :with_uninvoiced_time_entries, select("distinct customers.*").joins(:time_entries).where(:"time_entries.invoiced" => false)

end
