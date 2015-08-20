# encoding: utf-8
require_relative 'cell'

module BloXL
  class Sheet
    #attr_reader :name
    #def initialize(book, name, &block)
      #@book, @name = book, name
      #@main = Stack.new(&block)
      #@cells = []
    #end

    attr_reader :cells

    def initialize(&block)
      @cells = []
      @main = Stack.new(&block)
    end

    extend Forwardable

    def_delegators :@main, *DSL.instance_methods

    def prepare
      @main.render(self, 0, 0)
      self
    end

    def render(internal)
      #@main.render(self, 0, 0)
      expand_cells!

      @cells.each do |row|
        internal_row = internal.add_row
        row.each do |cell|
          cell.render(internal_row)
        end
      end
    end

    def set_cell(r, c, val, options = {})
      @cells[r] ||= []
      @cells[r][c] = Cell.new(val, options)
    end

    def set_cell?(r, c, val, options = {})
      @cells[r] ||= []
      @cells[r][c] ||= Cell.new(val, options)
    end

    private

    def expand_cells!
      max_c = @cells.compact.map(&:count).max
      (0...@cells.count).each do |r|
        @cells[r] ||= []
        (0...max_c).each do |c|
          @cells[r][c] ||= Cell.new(nil, {})
        end
      end
    end

    #def set_defaults(br, bc, er, ec, options)
      #(br...er).each do |r|
        #@cells[r] ||= []
        
        #(bc...ec).each do |c|
          #row[c] ||= Cell.new(nil, options)
        #end
      #end
    #end
  end
end
