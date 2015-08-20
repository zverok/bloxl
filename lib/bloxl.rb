require 'axlsx'

require_relative 'bloxl/block'
require_relative 'bloxl/table'
require_relative 'bloxl/stack'
require_relative 'bloxl/bar'

require_relative 'bloxl/sheet'

#class BloXL
  #attr_reader :axlsx
  
  #def initialize
    #@axlsx = Axlsx::Package.new
    #@sheet = @axlsx.workbook.add_worksheet(name: 'Sheet 1')
  #end
  
  #def row(*values)
    #@sheet.add_row values
    #self
  #end

  #def column(*values)
    #values.each do |val|
      #@sheet.add_row [val]
    #end
    #self
  #end

  #def table(*rows)
    #rows.each do |row|
      #@sheet.add_row row
    #end
    #self
  #end

  #def bar(&block)
    #Bar.new(self, &block)
  #end

  #class Bar
    #def initialize(bloxl, &block)
    #end
  #end

  #class Block
    #def initialize(r, c)
      #@r, @c = r, c
    #end

    #def render(board)
      
    #end
  #end
#end
