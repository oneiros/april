class Project < ActiveRecord::Base

  belongs_to :customer
  has_many :time_entries

  validates_presence_of :title

  def self.grouped_options
    customers = Customer.includes(:projects).order(:name).all
    customers.map{|c| [c.name, c.projects.map{|p| [p.title, p.id]}]}
  end

  def time_spent
    self.time_entries.map(&:duration).sum
  end

end
