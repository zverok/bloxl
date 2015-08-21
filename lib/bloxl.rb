require 'axlsx'

module BloXL
  %w[block table stack bar sheet book].each do |mod|
    require_relative "bloxl/#{mod}"
  end

  class << self
    extend Forwardable
    def_delegators Book, :open
  end
end
