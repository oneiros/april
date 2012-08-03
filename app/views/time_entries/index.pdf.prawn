require "prawn/measurement_extensions"

prawn_document :page_size => "A4", :filename => filename_for(@invoice, :timesheet => true) do |pdf|
  
  pdf.text "Zeitaufstellung zur Rechnung #{@invoice.number}", :align => :center, :size => 14.pt

  pdf.move_down 1.cm

  data = []

  data << ["Datum", "Std.", "Tätigkeiten"]

  @invoice.time_entries.order("date ASC").each do |time_entry|
    date = time_entry.date.strftime("%Y-%m-%d")
    duration = sprintf("%.2f", time_entry.duration)
    data << [date, duration, time_entry.comment]
  end

  pdf.table data do |t|
    t.cells.borders = []

    t.row(0).font_style = :bold

    t.column(1).align = :right
    t.row(0).column(1).align = :left
  end

end
