class TimeEntriesController < ApplicationController

  def index
    if params[:invoice_id]
      @invoice = Invoice.find(params[:invoice_id])
    else
      @time_entries_by_project = TimeEntry.by_project(:limit => 10)
    end

    respond_to do |format|
      format.html
      format.csv { render :text => TimeEntry.csv_export(@invoice.time_entries) }
    end
  end

  def new
    @time_entry = TimeEntry.new(:date => Date.today)
  end

  def create
    @time_entry = TimeEntry.new(params[:time_entry])
    if @time_entry.save
      redirect_to time_entries_path, :notice => "Success!"
    else
      render :action => "new"
    end
  end

  def edit
    @time_entry = TimeEntry.find(params[:id])
  end

  def update
    @time_entry = TimeEntry.find(params[:id])
    if @time_entry.update_attributes(params[:time_entry])
      redirect_to time_entries_path, :notice => "Success!"
    else
      render :action => "edit"
    end
  end

end
