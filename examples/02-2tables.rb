require 'bundler/setup'
$:.unshift 'lib'
require 'bloxl'

MARKS1 = [
  %w[A  F  B+],
  %w[B+ C- D+],
  %w[A- A  B+]
]

MARKS2 = [
  %w[D+ B- A ],
  %w[B+ A  C+],
  %w[A- B  A-]
]

STUDENTS = ['Bob', 'Ann', 'Kate']
CLASSES = ['Math', 'Phisics', 'Art']

BloXL.open('examples/output/2tables.xlsx') do |b|

  b.bar{
    b.stack{                                
      b.cell 'Semester 1'
      b.row                                   
      b.row ['', *CLASSES]  
      b.bar{                                
        b.column STUDENTS
        b.table MARKS1
      }
    }
    b.column
    b.stack{                                
      b.cell 'Semester 2'
      b.row                                   
      b.row ['', *CLASSES]  
      b.bar{                                
        b.column STUDENTS
        b.table MARKS2
      }
    }
  }
end
