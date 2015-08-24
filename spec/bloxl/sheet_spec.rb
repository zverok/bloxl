require 'bloxl/sheet'

module BloXL
  describe Sheet do
    let(:sheet){Sheet.new}
    
    describe :set_cell do
      it 'should expand cells array' do
        expect(sheet.cells).to eq []
        sheet.set_cell(0, 0, 'test')
        expect(sheet.cells.size).to eq 1
        expect(sheet.cells.first.size).to eq 1

        sheet.set_cell(5, 10, 'foo')
        expect(sheet.cells.size).to eq 6
        expect(sheet.cells[5].size).to eq 11
      end
    end

    describe :build do
      it 'works without block' do
        expect(sheet.build).to be_a Builder
        expect(sheet.cells).to be_empty

        sheet.build.row [1, 2, 3]
        sheet.build.row [4, 5, 6]
        expect(sheet.cells).to eq [[c(1), c(2), c(3)], [c(4), c(5), c(6)]]
      end

      it 'works with block' do
        expect(sheet.build{|b| b.row [1, 2, 3]}).to be_a Builder
        expect(sheet.cells).to eq [[c(1), c(2), c(3)]]
      end
    end

    describe :prepare do
    end

    describe :render do
      let(:axlsx){Axlsx::Worksheet.make}
      
      it 'should render cells according to setup' do
        sheet.set_cell(0, 0, 'test')
        sheet.set_cell(2, 3, 'foo')
        sheet.render(axlsx)

        expect(axlsx).to be_sheet_of(
          ['test', nil, nil, nil],
          [nil, nil, nil, nil],
          [nil, nil, nil, 'foo']
        )
      end
    end
  end
end
