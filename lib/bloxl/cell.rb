# encoding: utf-8
module BloXL
  class Cell
    def initialize(value, options)
      @value, @options = value, options
    end

    def render(internal_row)
      internal_row.add_cell @value
    end
  end
end
