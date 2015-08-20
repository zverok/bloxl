module BloXL
  describe Book do
    let(:book){Book.new}

    describe 'default sheet' do
      it 'should not create it initially' do
        expect(book.sheets).to be_empty
      end

      it 'should create it implicitly' do
        book.row [1, 2, 3]
        expect(book.sheets.count).to eq 1
        expect(book.sheets.first.prepare.cells).to eq [[c(1), c(2), c(3)]]
      end
    end

    describe :sheet do
      describe 'without block' do
        subject{book.sheet}

        it{should be_a Sheet}
        its(:'prepare.cells'){should be_empty}
      end

      describe 'with block' do
        subject{
          book.sheet{
            row [1, 2, 3]
          }
        }

        it{should be_a Sheet}
        its(:'prepare.cells'){should == [[c(1), c(2), c(3)]]}
      end
    end

    describe :save do
      let(:path){xlsx_path}
      
      it 'saves with path, provided on init' do
        expect(File.exists?(path)).to eq false
        Book.new(path).save
        expect(File.exists?(path)).to eq true
      end

      it 'saves new path' do
        expect(File.exists?(path)).to eq false
        Book.new.save(path)
        expect(File.exists?(path)).to eq true
      end

      it 'fails with no path' do
        expect{Book.new.save}.to raise_error(ArgumentError, /path/)
      end

      it 'writes data, actually!' do
        b = Book.new
        b.sheet{
          row [1, 2, 3]
        }
        b.sheet{
          row [4, 5, 6]
        }
        b.save(path)
        actual = Roo::Spreadsheet.open(path)
        expect(actual.sheet(0).to_a).to eq [[1, 2, 3]]
        expect(actual.sheet(1).to_a).to eq [[4, 5, 6]]
      end
    end

    describe :close do
    end

    #describe :open do
      #context 'without block' do
        #subject{Book.open('tmp/test.xlsx')}
        #it{should be_a Book}
        #it{should be_open}
        #its(:path){should == 'tmp/test.xlsx'}
        #specify{
          #expect(File.exists?('tmp/test.xlsx')).to eq false
        #}
      #end

      #context 'with block' do
        #subject{Book.open('tmp/test.xlsx')}
        #it{should be_a Book}
        #it{should_not be_open}
        #its(:path){should == 'tmp/test.xlsx'}
        #specify{
          #expect(File.exists?('tmp/test.xlsx')).to eq true
        #}
      #end
    #end

  end
end