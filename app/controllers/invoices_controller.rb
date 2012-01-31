class InvoicesController < ApplicationController

  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
    respond_to do |format|
      format.pdf do
        render :template => "invoice_templates/#{@invoice.invoice_template.file}"
      end
    end
  end

  def select_customer
    @customers = Customer.with_uninvoiced_time_entries
  end

  def select_time_entries
    @customer = Customer.find(params[:customer][:id])
    @time_entries = @customer.time_entries.uninvoiced
  end

  def new
    @customer = Customer.find(params[:customer][:id])
    params[:customer][:time_entry_ids].reject!{|id| id.blank?}
    @time_entries = @customer.time_entries.find(params[:customer][:time_entry_ids])
    @invoice = Invoice.new_for_customer(@customer, @time_entries)
  end

  def create
    @invoice = Invoice.new(params[:invoice])
    if @invoice.save
      redirect_to invoices_path, :notice => "Success!"
    else
      render :action => "new"
    end
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    if @invoice.update_attributes(params[:invoice])
      redirect_to invoices_path, :notice => "Success!"
    else
      render :action => "edit"
    end
  end

end
