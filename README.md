# BloXL

BloXL is high-level DSL for creating full-featured XLSX (and, in future,
other spreadsheet formats) reports with formatting, charts, formula and
heck.

BloXL is currently in the very early stage of development, consisting
just of vision and some code, implementing first steps of this vision.
Like this:

> The journey of a thousand miles begins with a single step. ― Lao Tzu

BloXL is NOT some "new XLSX writer from scratch" -- it is hi-level wrapper
of existing one ([axlsx](https://github.com/randym/axlsx) currently,
though [write_xlsx](https://github.com/cxn03651/write_xlsx/) considered
as an option).

## Why

Unfortunately, spreadsheets (and, most oftenly, Excel spreadsheets) is
still the only option for rich, detailed and editable reports, especially
for business environment.

There are two very mature and full-featured libraries, targeting production
of xlsx (mentioned above). Though, those libraries, tightly resembling XLSX
API and structure, are rather like "assembler" when you are trying to create
some complex reports, with formulas, charts, conditional formatting and stuff.

So, BloXL tries to close this gap. In fact, it tries to make "spreadsheet
output" feature more like "views", modular and embeddable.

## How

Steps to achieve aforementioned goals:

1. DSL for hierarchical description of spreadsheet data, like "two areas,
  first of which has column with labels and column with values; another
  one is a table with header row, body and footer... and so on" -- **done**;
2. notions of "stylesheets", separation of content from style (somehow
  already present in xlsx format, yet hard to use); cascading of styles --
  **next target**;
3. DSL for chart description, allowing to describe it as-easy-as-possible,
  like "line chart from this array", working uniformly for data on sheets
  and data in Ruby Arrays;
4. DSL for expressions, converted to Excel formulae, for defining cell
  dependencies and conditional formatting;
5. Clean API for modular and reusable design of parts of a report.

## What

For now, only step (1) from above list is ready. BloXL allows you to
write code like this:

```ruby
MARKS = [
  ['A', 'F', 'B+']
  ['B+', 'C-', 'D+']
  ['A-', 'A', 'B+']
]

BloXL.open('semester1.xlsx) do
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
```

Results in:

<img src="https://raw.github.com/zverok/bloxl/master/examples/screenshots/01-simple.png" alt="Simple table"/>

You may argue it is not seem THAT better than raw Axlsx code? Then look
at _slightly_ more complex example:

```ruby
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
```

This is like table from ex.1, just placed two times alongside each other:

<img src="https://raw.github.com/zverok/bloxl/master/examples/screenshots/02-2tables.png" alt="Simple table"/>

Also, this approach allows furthed advances in styling: each grouped area can
be styled separately with inplace style or "style class" (which are planned
to be cascaded in CSS fashion).

Look ahead!
