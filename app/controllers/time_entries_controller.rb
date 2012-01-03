class TimeEntriesController < ApplicationController

  def index
    @time_entries = TimeEntry.all
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
