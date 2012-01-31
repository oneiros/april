class TimeEntry < ActiveRecord::Base

  belongs_to :project
  has_one :customer, :through => :project

  validates_presence_of :duration, :comment, :date

  scope :uninvoiced, where(:invoiced => false)

  def to_s
    "#{self.date} - #{duration}h - #{project.title} - #{comment}"
  end

end
