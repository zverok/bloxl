describe BloXL do
  let(:bloxl){BloXL.new}
  
  describe :row do
    it 'works' do
      expect(bloxl.row('one', 'two', 'three')).to make_spreadsheet [['one', 'two', 'three']]
    end

    it 'creates subsequent rows' do
      expect(bloxl.row('one', 'two', 'three').row.row('foo')).
        to make_spreadsheet [['one', 'two', 'three'], [nil, nil, nil], ['foo', nil, nil]]
    end
  end

  describe :column do
    it 'works' do
      expect(bloxl.column('one', 'two', 'three')).to make_spreadsheet [['one'], ['two'], ['three']]
    end

    it 'creates subsequent columns' do
      expect(bloxl.column('one', 'two', 'three').column.column('foo')).
        to make_spreadsheet [['one'], ['two'], ['three'], ['foo']]
    end
  end

  describe :table do
    it 'works' do
      expect(bloxl.table(['one', 'two'], ['three', 'four'], ['five', 'six'])).
        to make_spreadsheet [['one', 'two'], ['three', 'four'], ['five', 'six']]
    end
  end

  describe :bar do
  end

  describe :stack do
  end

  describe 'combination' do
  end
end
