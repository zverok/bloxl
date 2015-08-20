module BloXL
  describe Bar do
    let(:bar){Bar.new}

    context 'with one table' do
      before{
        bar.table [[1, 2], [3, 4]]
      }

      it 'should have a child' do
        expect(bar.children.count).to eq 1
        expect(bar.children.first).to be_a Table
      end

      describe :render do
        subject{Sheet.new}

        before{
          bar.render(subject)
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
        bar.table [[1, 2], [3, 4]]
        bar.table [[5, 6, 7]]
      }

      it 'should have a child' do
        expect(bar.children.count).to eq 2
        expect(bar.children).to all(be_a Table)
      end

      describe :render do
        subject{Sheet.new}

        before{
          bar.render(subject)
        }

        its(:cells){should ==
          [
            [Cell.new(1), Cell.new(2), Cell.new(5), Cell.new(6), Cell.new(7)],
            [Cell.new(3), Cell.new(4), Cell.new(nil), Cell.new(nil), Cell.new(nil)],
          ]
        }
      end
    end
  end
end
