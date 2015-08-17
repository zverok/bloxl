# encoding: utf-8
module BloXL
  class Block
    def initialize(options = {}, &block)
      @options = options
      #@children = []
      block and instance_eval(&block)
    end

    attr_reader :children

    def render(sheet, r, c)
      fail NotImplementedError
    end

    protected

    private

    #include DSL

    #def add_block(block)
      #@children << block
    #end

  end
end
