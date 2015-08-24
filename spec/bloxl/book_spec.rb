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
        expect(book.sheets.first.cells).to eq [[c(1), c(2), c(3)]]
      end
    end

    describe :sheet do
      describe 'without block' do
        before{book.sheet}
        subject{book.sheets.last}

        it{should be_a Sheet}
        its(:cells){should be_empty}
      end

      describe 'with block' do
        before{
          book.sheet{|b|
            b.row [1, 2, 3]
          }
        }
        subject{book.sheets.last}

        it{should be_a Sheet}
        its(:cells){should == [[c(1), c(2), c(3)]]}
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
        b.sheet{|s|
          s.row [1, 2, 3]
        }
        b.sheet{|s|
          s.row [4, 5, 6]
        }
        b.save(path)
        actual = Roo::Spreadsheet.open(path)
        expect(actual.sheet(0).to_a).to eq [[1, 2, 3]]
        expect(actual.sheet(1).to_a).to eq [[4, 5, 6]]
      end
    end

    describe :close do
      let(:path){xlsx_path}
      let(:book){Book.new(path)}
      
      it 'is not closed on creation' do
        expect(File.exists?(path)).to eq false
        expect(book).to be_open
        expect(book).not_to be_closed
      end

      it 'is closed, when, errr, closed' do
        book.close
        expect(book).not_to be_open
        expect(book).to be_closed
      end

      it 'is auto-saved on close' do
        book.close
        expect(File.exists?(path)).to eq true
        expect{book.save}.to raise_error(RuntimeError, /closed/)
      end

    end

    describe :open do
      let(:path){xlsx_path}
      
      context 'without block' do
        subject!{Book.open(path)}
        it{should be_a Book}
        it{should be_open}
        its(:path){should == path}
        specify{
          expect(File.exists?(path)).to eq false
        }
      end

      context 'with block' do
        subject!{Book.open(path){|b| b.sheet{|s| s.row [1, 2, 3]}}}
        it{should be_a Book}
        it{should_not be_open}
        its(:path){should == path}
        specify{
          expect(File.exists?(path)).to eq true
        }
      end
    end

  end
end
