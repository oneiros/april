class TimeEntry < ActiveRecord::Base

  belongs_to :project
  belongs_to :invoice
  has_one :customer, :through => :project

  validates_presence_of :duration, :comment, :date

  scope :uninvoiced, where(:invoiced => false)

  before_save :set_invoiced

  def self.by_project(options = {})
    result = Hash.new
    Project.all.each do |project|
      time_entries = project.time_entries.order("date DESC")
      time_entries = time_entries.limit(options[:limit]) if options[:limit]
      result[project] = time_entries if time_entries.any?
    end
    result
  end

  def self.csv_export(time_entries)
    time_entries.sort!{|a,b| a.date <=> b.date}
    time_entries.map{|t| t.to_csv}.join("\n")
  end

  def to_s
    "#{self.date} - #{duration}h - #{project.title} - #{comment}"
  end

  def to_csv
    "\"#{self.date}\",#{self.duration},\"#{self.comment.chomp}\""
  end

  private

  def set_invoiced
    if self.invoice_id
      self.invoiced = true
    end
  end

end
