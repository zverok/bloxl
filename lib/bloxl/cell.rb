# encoding: utf-8
module BloXL
  class Cell
    attr_reader :value, :options
    
    def initialize(value, options = {})
      @value, @options = value, options
    end

    def ==(other)
      other.is_a?(Cell) && value == other.value
    end

    def render(internal_row)
      internal_row.add_cell @value
    end
  end
end
