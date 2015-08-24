require 'bloxl/builder'

module BloXL
  describe Builder do
    let(:sheet){Sheet.new}
    let(:builder){Builder.new(sheet)}
    subject{sheet.cells}
    
    describe :cell do
      before{
        builder.cell 'foo'
      }
      it{should == [[c('foo')]]}
    end

    describe :row do
      before{
        builder.row ['foo', 'bar']
      }
      it{should == [[c('foo'), c('bar')]]}
    end

    describe :column do
      before{
        builder.column ['foo', 'bar']
      }
      it{should == [[c('foo')], [c('bar')]]}
    end

    describe :table do
      before{
        builder.table [[1, 2], [3, 4]]
      }
      it{should == [[c(1), c(2)], [c(3), c(4)]]}
    end

    describe 'subsequent' do
      before{
        builder.table [[1, 2], [3, 4]]
        builder.table [[5, 6], [7, 8]]
      }
      it{should == [[c(1), c(2)], [c(3), c(4)], [c(5), c(6)], [c(7), c(8)]]}
    end

    describe :stack do
      before{
        builder.stack{
          builder.table [[1, 2], [3, 4]]
          builder.table [[5, 6], [7, 8]]
        }
      }
      it{should == [[c(1), c(2)], [c(3), c(4)], [c(5), c(6)], [c(7), c(8)]]}
    end

    describe :bar do
      before{
        builder.bar{
          builder.table [[1, 2], [3, 4]]
          builder.table [[5, 6], [7, 8]]
        }
      }
      it{should == [[c(1), c(2), c(5), c(6)], [c(3), c(4), c(7), c(8)]]}
    end

    context 'filling the gaps' do
      before{
        builder.stack{
          builder.cell 1
          builder.row [2, 3]
        }
      }
      it{should == [[c(1), c(nil)], [c(2), c(3)]]}
    end

    describe 'all at once' do
      before{
        builder.stack{
          builder.stack{
            builder.cell 1
            builder.cell 2
          }
          builder.row
          builder.table [[5, 6], [7, 8]]
          builder.row
          builder.bar{
            builder.column [9, 10]
            builder.column
            builder.column [11, 12]
          }
        }
      }
      it{should == [
        [c(1),   c(nil),  c(nil)],
        [c(2),   c(nil),  c(nil)],
        [c(nil), c(nil),  c(nil)],
        [c(5),   c(6),    c(nil)],
        [c(7),   c(8),    c(nil)],
        [c(nil), c(nil),  c(nil)],
        [c(9),   c(nil),  c(11)],
        [c(10),  c(nil),  c(12)],
      ]}
    end
  end
end
