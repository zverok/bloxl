# encoding: utf-8
module BloXL
  module DSL
    def cell(value = nil, options = {})
      table [[value]], options
    end

    def row(array = [], options = {})
      table [array], options
    end

    def column(array = [], options = {})
      table [array].transpose, options
    end

    def table(array2d, options = {})
      add_block(Table.new(array2d, options))
    end

    def bar(options = {}, &block)
      add_block(Bar.new(options, &block))
    end

    def stack(options = {}, &block)
      add_block(Stack.new(options, &block))
    end

    def formula(options = {}, &block)
    end
  end
end
