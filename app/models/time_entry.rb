class TimeEntry < ActiveRecord::Base

  belongs_to :project
  has_one :customer, :through => :project

  validates_presence_of :duration, :comment, :date

end
