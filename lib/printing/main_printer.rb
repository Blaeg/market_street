module MainPrinter

  def check_box(pdf,x_location,y_location, check_size = 12)
    pdf.text "X", :at => [x_location,y_location], :size => check_size
  end
  
  # Converts the lines to actual text
  #
  # @param [pdf] pdf to be printed on
  # @param [lines] array of string to be printed normally within a bounding box
  def print_lines(pdf, lines)
    lines.each do |line|
      pdf.text line
    end if lines
  end
  
  
  # Converts the string to actual text
  #
  # @param [pdf] pdf to be printed on
  # @param [display_string] string to be printed
  # @param [yml_info] customization
  def print_line(pdf, display_string, yml_info)
    
    arguements         = {}
    if yml_info['arguements']['at']
      x_loc = yml_info['arguements']['at'][0].to_f
      y_loc = yml_info['arguements']['at'][1].to_f
      arguements[:at]    = [x_loc, y_loc]
    end
    
    if yml_info['arguements']['size']
      arguements[:size]  = yml_info['arguements']['size']
    else
      arguements[:size]  = 13
    end
    pdf.draw_text display_string, arguements
  end  
end