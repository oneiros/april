require "prawn/measurement_extensions"

prawn_document :page_size => @invoice.invoice_template.paper_size, :filename => filename_for(@invoice) do |pdf|

  pdf.stroke_color "007500"
  pdf.horizontal_line pdf.bounds.left, pdf.bounds.right, :at => pdf.bounds.top - 18.mm
  pdf.stroke
  pdf.horizontal_line pdf.bounds.left, pdf.bounds.right, :at => 23.mm
  pdf.stroke

  pdf.bounding_box [13.cm, pdf.bounds.top], :width => 5.cm do
    pdf.text @invoice.invoice_template.header, :align => :right
  end

  pdf.bounding_box [1.cm, 24.cm], :width => 7.cm do
    pdf.text @invoice.invoice_template.address_line, :size => 6
    pdf.move_down 15
    pdf.text @invoice.customer.name
    pdf.text @invoice.contact_person.name if @invoice.contact_person and !@invoice.contact_person.name.blank?
    pdf.text @invoice.customer.address_line_1
    pdf.text @invoice.customer.address_line_2 unless @invoice.customer.address_line_2.blank?
    pdf.move_down 20
    pdf.text "#{@invoice.customer.zip} #{@invoice.customer.city}"
    pdf.text @invoice.customer.country, :style => :bold
  end

  pdf.bounding_box [13.cm, 19.cm], :width => 5.cm do
    pdf.text @invoice.date.to_s
  end

  pdf.bounding_box [0, 18.cm], :width => pdf.bounds.width do
    pdf.text "Invoice ##{@invoice.number}", :style => :bold
    pdf.move_down 20

    data = Array.new
    data << ["Qty.", "Unit", "Description", "Unit Price", "Total Price"]
    @invoice.line_items.each do |item|
      data << [number_with_delimiter(item.quantity), item.unit, item.description, format_money(item.unit_price), format_money(item.total)]
    end
    data << ["", "", "", "Total", format_money(@invoice.total_with_tax)]
    pdf.table(data, :column_widths => {0 => 2.cm, 1 => 2.cm, 2 => 84.mm, 3 => 28.mm, 4 => 28.mm}) do |table|
      table.cells.borders = []
      table.row(0).borders = [:bottom]
      table.row(0).border_color = "007500"
      table.column(0).align = :right
      table.column(1).align = :center
      table.column(4).align = :right
      table.row(-4).column(4).borders = [:bottom]
      table.row(-2).column(4).borders = [:bottom]
      table.row(-2).column(4).border_width = 2
      table.row(-1).columns(3..4).font_style = :bold
    end

    pdf.move_down 30

    pdf.text @invoice.comment if @invoice.comment
  end

  pdf.column_box [0, 2.cm], :width => pdf.bounds.width do
    pdf.font_size 8
    pdf.text @invoice.invoice_template.footer_left

    pdf.bounds.move_past_bottom

    pdf.text @invoice.invoice_template.footer_middle

    pdf.bounds.move_past_bottom

    pdf.text @invoice.invoice_template.footer_right
  end

end
