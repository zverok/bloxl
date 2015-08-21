require 'bundler/setup'
$:.unshift 'lib'
require 'bloxl'

MARKS = [
  %w[A  F  B+],
  %w[B+ C- D+],
  %w[A- A  B+]
]


BloXL.open('examples/output/simple.xlsx') do
  row ['Semester 1 marks']
  row                                   # empty row
      
  stack{                                # place children under each other
                                        #   (the same as default behavior, yet
                                        #   also provides logical grouping of children)
    row ['', 'Math', 'Phisics', 'Art']  # one-dimensional array horizontally
    bar{                                # place children leftmost of each other
      column ['Bob', 'Ann', 'Kate']     # one-dimensional array vertically
      table MARKS                       # two-dimensional table
    }
  }
end
