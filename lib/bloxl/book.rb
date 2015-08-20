module BloXL
  class Book
    attr_reader :sheets, :path
    
    def initialize(path = nil, &block)
      @path = path
      @sheets = []
      block and instance_eval(&block)
    end

    extend Forwardable
    def_delegators :default_sheet, *DSL.instance_methods

    def default_sheet
      @default_sheet ||= begin
        @sheets << Sheet.new
        @sheets.last
      end
    end

    def sheet(&block)
      @sheets << Sheet.new(&block)
      @sheets.last
    end

    def save(path = nil)
      open? or fail(RuntimeError, 'Book is already closed')
      path ||= @path or fail(ArgumentError, 'Save path is not set')
      package = Axlsx::Package.new
      @sheets.each(&:prepare).each{|sheet| sheet.render(package.workbook.add_worksheet)}

      package.serialize(path)
    end

    def close(path = nil)
      save(path)
      @closed = true
    end

    def closed?
      @closed
    end

    def open?
      !closed?
    end

    class << self
      def open(path = nil, &block)
        new(path, &block).tap{|book|
          book.close if block
        }
      end
    end
    
    #class << self
      #def make(path = nil, &block)
        #new.make(&block).tap{|book|
          #path and book.save(path)
        #}
      #end
    #end
    
    #def initialize
      #@package = Axlsx::Package.new
      #@sheets = []
    #end

    #def make(&block)
      #instance_eval(&block)

      #self
    #end
    
    #def save(path)
      #render!
      
      #@package.use_shared_strings = true
      #@package.serialize(path)

      #self
    #end

    #private

    #def render!
      #@sheets.each{|sheet|
        #sheet.render(@package.workbook.add_worksheet(name: sheet.name))
      #}
    #end

  end
end
