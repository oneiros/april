class InvoiceTemplatesController < ApplicationController

  def index
    @invoice_templates = InvoiceTemplate.all
  end

  def new
    @invoice_template = InvoiceTemplate.new
  end

  def create
    @invoice_template = InvoiceTemplate.new(params[:invoice_template])
    if @invoice_template.save
      redirect_to invoice_templates_path, :notice => "Success!"
    else
      render :action => "new"
    end
  end

  def edit
    @invoice_template = InvoiceTemplate.find(params[:id])
  end

  def update
    @invoice_template = InvoiceTemplate.find(params[:id])
    if @invoice_template.update_attributes(params[:invoice_template])
      redirect_to invoice_templates_path, :notice => "Success!"
    else
      render :action => "edit"
    end
  end

end
