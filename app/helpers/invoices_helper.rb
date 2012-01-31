# encoding: utf-8
module InvoicesHelper
  
  def format_money(amount)
    sprintf("%.2f €", amount.to_f).sub(".", ",")
  end
  
  def format_date(date)
    date.strftime("%d.%m.%Y")
  end

end
