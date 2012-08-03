# encoding: utf-8
module InvoicesHelper

  def filename_for(invoice, options = {})
    if options[:timesheet]
      "timesheet-#{invoice.number}.pdf"
    else
      date = invoice.date.strftime("%Y-%m")
      "#{date}-#{invoice.customer.handle}-#{invoice.number}.pdf"
    end
  end

  def format_money(amount)
    sprintf("%.2f €", amount.to_f).sub(".", ",")
  end
  
  def format_date(date)
    date.strftime("%d.%m.%Y")
  end

  def default_comments_for_js
    InvoiceTemplate.all.map do |t| 
      "\"#{t.id}\": \"#{t.default_comment}\""
    end.join(", ")
  end

  def contact_people_for_js
    Customer.all.map do |c|
      options = options_from_collection_for_select(c.contact_people, :id, :name)
      "\"#{c.id}\": \"#{escape_javascript(options)}\""
    end.join(", ")
  end

end
