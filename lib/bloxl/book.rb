module BloXL
  class Book
    attr_reader :sheets
    
    def initialize(path = nil)
      @path = path
      @sheets = []
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
      path ||= @path or fail(ArgumentError, "Save path is not set")
      package = Axlsx::Package.new
      @sheets.each(&:prepare).each{|sheet| sheet.render(package.workbook.add_worksheet)}

      package.serialize(path)
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
