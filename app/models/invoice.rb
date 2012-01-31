class Invoice < ActiveRecord::Base

  attr_accessor :time_entry_ids

  belongs_to :customer
  belongs_to :invoice_template
  belongs_to :contact_person

  has_many :line_items

  accepts_nested_attributes_for :line_items

  validates_presence_of :date, :number
  validates_uniqueness_of :number

  after_create :update_time_entries

  def self.new_for_customer(customer, time_entries)
    times_per_project = Hash.new
    time_entries.each do |time_entry|
      times_per_project[time_entry.project] ||= BigDecimal.new(0)
      times_per_project[time_entry.project] +=  time_entry.duration
    end
    invoice = self.new(:date => Date.today, :customer => customer, :time_entry_ids => time_entries.map(&:id))
    times_per_project.each do |project, duration|
      invoice.line_items << LineItem.new(:quantity => duration, :unit => "h", :description => project.title)
    end
    invoice
  end

  def total
    total = 0
    line_items.each do |line_item|
      total += line_item.total
    end
    total
  end

  def taxes
    taxes = Hash.new
    line_items.each do |line_item|
      taxes[line_item.vat] ||= 0
      taxes[line_item.vat] += line_item.total / 100.0 * line_item.vat
    end
    taxes
  end

  def total_with_tax
    total_with_tax = total
    taxes.each do |rate, sum|
      total_with_tax += sum
    end
    total_with_tax
  end

  private

  def update_time_entries
    unless @time_entry_ids.blank?
      TimeEntry.find(@time_entry_ids).each do |time_entry|
        time_entry.update_attributes(:invoiced => true)
      end
    end
  end

end
