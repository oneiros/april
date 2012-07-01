class Invoice < ActiveRecord::Base

  belongs_to :customer
  belongs_to :invoice_template
  belongs_to :contact_person

  has_many :line_items
  has_many :time_entries

  accepts_nested_attributes_for :line_items

  validates_presence_of :date, :number
  validates_uniqueness_of :number

  def self.new_for_customer(customer, time_entries)
    times_per_project = Hash.new
    time_entries.each do |time_entry|
      times_per_project[time_entry.project] ||= BigDecimal.new(0)
      times_per_project[time_entry.project] +=  time_entry.duration
    end
    invoice = self.new(
      :date => Date.today, 
      :customer => customer, 
      :time_entry_ids => time_entries.map(&:id),
      :number => self.next_number
    )
    times_per_project.each do |project, duration|
      invoice.line_items << LineItem.new(
        :quantity => duration, 
        :unit => "h", 
        :description => project.title, 
        :unit_price => project.default_rate,
        :vat => project.default_vat
      )
    end
    invoice
  end

  def self.next_number
    self.connection.select_value("SELECT MAX(number) FROM invoices").to_i + 1
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

end
