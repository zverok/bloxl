module BloXL
  describe 'one-sheet workbook' do
    before{
      BloXL.open('tmp/one-sheet.xlsx'){|b|
        b.bar{
          b.column ['test', 'me']
          b.column
          b.row ['love', 'me', 'tenderly']
        }
      }
    }
    subject{
      Roo::Spreadsheet.open('tmp/one-sheet.xlsx').sheet(0).to_a
    }
    it{should == [
      ['test', nil, 'love', 'me', 'tenderly'],
      ['me'  , nil, nil   , nil , nil       ]
    ]}
  end
end
