require 'bundler/setup'
$:.unshift 'lib'
require 'bloxl'

MARKS = [
  %w[A  F  B+],
  %w[B+ C- D+],
  %w[A- A  B+]
]


BloXL.open('examples/output/simple.xlsx') do |b|
  b.row ['Semester 1 marks']
  b.row                                   # empty row
      
  b.stack{                                # place children under each other
                                          #   (the same as default behavior, yet
                                          #   also provides logical grouping of children)
    b.row ['', 'Math', 'Phisics', 'Art']  # one-dimensional array horizontally
    b.bar{                                # place children leftmost of each other
      b.column ['Bob', 'Ann', 'Kate']     # one-dimensional array vertically
      b.table MARKS                       # two-dimensional table
    }
  }
end
