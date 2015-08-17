describe BloXL do
  let(:bloxl){BloXL.new}
  
  describe :row do
    it 'works with any number of cells' do
      expect(bloxl.row('one', 'two', 'three')).to make_spreadsheet [['one', 'two', 'three']]
    end

    it 'creates subsequent rows' do
      expect(bloxl.row('one', 'two', 'three').row.row('foo')).
        to make_spreadsheet [['one', 'two', 'three'], [nil, nil, nil], ['foo', nil, nil]]
    end
  end

  describe :column do
  end

  describe :table do
  end

  describe :bar do
  end

  describe :stack do
  end

  describe 'combination' do
  end
end
