class TimeEntriesController < ApplicationController

  def index
  end

  def new
    @time_entry = TimeEntry.new
  end

end
