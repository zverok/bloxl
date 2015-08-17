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
end
