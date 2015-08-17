require 'rspec/its'
require 'roo'

$:.unshift 'lib'

require 'bloxl'

RSpec::Matchers.define :make_spreadsheet do |expected|
  match do |bloxl|
    # FIXME haha
    path = 'tmp/spec.xlsx'
    bloxl.axlsx.serialize(path)
    @actual = Roo::Spreadsheet.open(path).sheet(0).to_a
    @actual == expected
  end

  failure_message do |actual|
    "expected that spreadsheet contains #{expected}, though #{@actual}" 
  end
end

class Roo::Base
  alias_method :each_non_patched, :each

  # Roo can't handle totally empty sheets (at least, created by Axlsx)
  def each(*args, &block)
    last_row.nil? ? [[]] : each_non_patched(*args, &block)
  end
end
