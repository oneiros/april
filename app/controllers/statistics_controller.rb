class StatisticsController < ApplicationController

  def index
    @invoice_sums = Invoice.sums
  end

end
