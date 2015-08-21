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

BloXL.open('examples/output/2tables.xlsx') do

  bar{
    stack{                                
      cell 'Semester 1'
      row                                   
      row ['', *CLASSES]  
      bar{                                
        column STUDENTS
        table MARKS1
      }
    }
    column
    stack{                                
      cell 'Semester 2'
      row                                   
      row ['', *CLASSES]  
      bar{                                
        column STUDENTS
        table MARKS2
      }
    }
  }
end
