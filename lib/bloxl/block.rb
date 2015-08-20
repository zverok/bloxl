require_relative 'dsl'

module BloXL
  class Block
    def initialize(options = {})
      @options = options
    end

    def render(sheet, r = 0, c = 0)
      _render(sheet, r, c).tap{|w, h|
        (r...r+h).each do |cr|
          (c...c+w).each do |cc|
            sheet.set_cell?(cr, cc, nil)
          end
        end
      }
    end

    protected

    def _render(sheet, _r, _c)
      fail NotImplementedError
    end
  end

  class Group < Block
    attr_reader :children

    def initialize(options = {}, &block)
      super(options)
      
      @children = []
      block and instance_eval(&block)
    end
    
    include DSL

    private

    def add_block(block)
      @children << block
    end
  end
end
