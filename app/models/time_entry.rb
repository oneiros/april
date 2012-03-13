class TimeEntry < ActiveRecord::Base

  belongs_to :project
  has_one :customer, :through => :project

  validates_presence_of :duration, :comment, :date

  scope :uninvoiced, where(:invoiced => false)

  def self.by_project(options = {})
    result = Hash.new
    Project.all.each do |project|
      time_entries = project.time_entries.order("date DESC")
      time_entries = time_entries.limit(options[:limit]) if options[:limit]
      result[project] = time_entries if time_entries.any?
    end
    result
  end

  def to_s
    "#{self.date} - #{duration}h - #{project.title} - #{comment}"
  end

end
