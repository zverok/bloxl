module BloXL
  describe DSL do
    let(:stack){Stack.new}
    let(:sheet){Sheet.new}
    let(:rendered){sheet.tap{|s| stack.render(sheet)}}
    subject{rendered.cells}

    describe :cell do
      before{
        stack.cell 'foo'
      }
      it{should == [[c('foo')]]}
    end

    describe :row do
      before{
        stack.row ['foo', 'bar']
      }
      it{should == [[c('foo'), c('bar')]]}
    end

    describe :column do
      before{
        stack.column ['foo', 'bar']
      }
      it{should == [[c('foo')], [c('bar')]]}
    end

    describe :table do
      before{
        stack.table [[1, 2], [3, 4]]
      }
      it{should == [[c(1), c(2)], [c(3), c(4)]]}
    end

    describe :stack do
      before{
        stack.stack{
          cell 1
          cell 2
        }
      }
      it{should == [[c(1)], [c(2)]]}
    end

    describe :bar do
      before{
        stack.bar{
          cell 1
          cell 2
        }
      }
      it{should == [[c(1), c(2)]]}
    end

    describe 'multiple & nested' do
      before{
        stack.stack{
          stack{
            cell 1
            cell 2
          }
          row
          table [[5, 6], [7, 8]]
          row
          bar{
            column [9, 10]
            column
            column [11, 12]
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
