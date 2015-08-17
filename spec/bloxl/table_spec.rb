module BloXL
  describe Table do
    let(:data){
      [
        ['one', 'two'],
        ['four', 'five']
      ]
    }
    let(:table){Table.new(data)}

    describe :render do
      subject{Sheet.new}

      context 'by default' do
        before{table.render(subject)}
        its(:cells){should ==
          [
            [Cell.new('one'), Cell.new('two')],
            [Cell.new('four'), Cell.new('five')],
          ]
        }
      end

      context 'with different start coordinates' do
        let(:shifted_data){
          [nil] + data.map{|r| [nil, *r.map(&Cell.method(:new))]}
        }
        before{table.render(subject, 1, 1)}
        its(:cells){should == shifted_data}
      end
    end
  end
end
