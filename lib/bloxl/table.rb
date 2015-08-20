# encoding: utf-8
module BloXL
  class Table < Block
    def initialize(data, options = {})
      super(options)
      
      data.is_a?(Array) && data.each{|r| r.is_a?(Array)} or
        fail ArgumentError, "Not a 2D array: #{data.inspect}"
        
      @data = data
    end

    protected
    
    def _render(sheet, r, c)
      @data.each_with_index do |row, dr|
        row.each_with_index do |val, dc|
          sheet.set_cell(r + dr, c + dc, val, @options)
        end
      end

      [@data.map(&:count).max, @data.count]
    end
  end
end
