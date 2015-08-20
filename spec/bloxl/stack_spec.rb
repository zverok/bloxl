module BloXL
  describe Stack do
    let(:stack){Stack.new}

    context 'with one table' do
      before{
        stack.table [[1, 2], [3, 4]]
      }

      it 'should have a child' do
        expect(stack.children.count).to eq 1
        expect(stack.children.first).to be_a Table
      end

      describe :render do
        subject{Sheet.new}

        before{
          stack.render(subject)
        }

        its(:cells){should ==
          [
            [Cell.new(1), Cell.new(2)],
            [Cell.new(3), Cell.new(4)],
          ]
        }
      end
    end

    context 'with several tables' do
      before{
        stack.table [[1, 2], [3, 4]]
        stack.table [[5, 6, 7]]
      }

      it 'should have a child' do
        expect(stack.children.count).to eq 2
        expect(stack.children).to all(be_a Table)
      end

      describe :render do
        subject{Sheet.new}

        before{
          stack.render(subject)
        }

        its(:cells){should ==
          [
            [Cell.new(1), Cell.new(2), Cell.new(nil)],
            [Cell.new(3), Cell.new(4), Cell.new(nil)],
            [Cell.new(5), Cell.new(6), Cell.new(7)],
          ]
        }
      end
    end
  end
end
