# encoding: utf-8
require 'axlsx'
require_relative './sheet'

module BloXL
  class Book
    class << self
      def make(path = nil, &block)
        new.make(&block).tap{|book|
          path and book.save(path)
        }
      end
    end
    
    def initialize
      @package = Axlsx::Package.new
      @sheets = []
    end

    def make(&block)
      instance_eval(&block)

      self
    end
    
    def save(path)
      render!
      
      @package.use_shared_strings = true
      @package.serialize(path)

      self
    end

    private

    def render!
      @sheets.each{|sheet|
        sheet.render(@package.workbook.add_worksheet(name: sheet.name))
      }
    end

    def sheet(name, &block)
      @sheets << Sheet.new(self, name, &block)
    end
  end
end
