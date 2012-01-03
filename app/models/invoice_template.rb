class InvoiceTemplate < ActiveRecord::Base

  has_many :invoices

  validates_presence_of :title, :file
  validates_uniqueness_of :title

  def self.file_names
    Dir.glob("#{Rails.root}/app/views/invoice_templates/*.pdf.prawn").map{|f| File.basename(f, ".pdf.prawn")}
  end

end
