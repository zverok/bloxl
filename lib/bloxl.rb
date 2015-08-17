require 'axlsx'

class BloXL
  attr_reader :axlsx
  
  def initialize
    @axlsx = Axlsx::Package.new
    @sheet = @axlsx.workbook.add_worksheet(name: 'Sheet 1')
  end
  
  def row(*values)
    @sheet.add_row values
    self
  end

  def column(*values)
    values.each do |val|
      @sheet.add_row [val]
    end
    self
  end

  def table(*rows)
    rows.each do |row|
      @sheet.add_row row
    end
    self
  end
end
