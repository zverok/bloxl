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

    describe 'DSL' do
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
