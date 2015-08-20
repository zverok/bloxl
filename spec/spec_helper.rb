require 'rspec/its'
require 'roo'

$:.unshift 'lib'

require 'bloxl'

RSpec::Matchers.define :be_sheet_of do |*expected_rows|
  match do |sheet|
    # FIXME haha
    path = 'tmp/spec.xlsx'
    Axlsx::Package.new(workbook: sheet.workbook).serialize(path)
    @actual = Roo::Spreadsheet.open(path).sheet(0).to_a
    @actual == expected_rows
  end

  failure_message do |actual|
    "expected that worksheet to contain #{expected_rows}, though #{@actual}" 
  end
end

def c(*arg)
  BloXL::Cell.new(*arg)
end

class Roo::Base
  alias_method :each_non_patched, :each

  # Roo can't handle totally empty sheets (at least, created by Axlsx)
  def each(*args, &block)
    last_row.nil? ? [[]] : each_non_patched(*args, &block)
  end
end

class Axlsx::Worksheet
  def self.make(workbook = nil)
    (workbook || Axlsx::Workbook.new).add_worksheet
  end
end
