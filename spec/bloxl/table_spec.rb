module BloXL
  describe Table do
    let(:data){
      [
        ['one', 'two', 'three'],
        ['four', 'five', 'six'],
        ['seven', 'eight', 'nine']
      ]
    }
    let(:table){Table.new(data)}

    describe :render do
      subject{Axlsx.make}

      context 'by default' do
        before{table.render(subject)}
        it{should be_spreedsheet(data)}
      end

      context 'with different start coordinates' do
        let(:shifted_data){
          [[nil] * 4] + data.map{|r| [nil, *r]}
        }
        before{table.render(subject, 1, 1)}
        it{should be_spreedsheet(shifted_data)}
      end
    end
  end
end
