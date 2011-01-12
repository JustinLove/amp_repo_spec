shared_examples_for 'local_repository#relative_join' do
  it {should respond_to :relative_join}

  describe "current directory unspecified" do
    subject {described_class.new('')}
    it 'should give a relative path' do
      subject.relative_join('Ampfile').should == 'Ampfile'
    end
  end

  describe "current directory specified" do
    subject {described_class.new('/path')}
    it 'should accept a current directory' do
      subject.relative_join('subdir/Ampfile', '/path').should == 'subdir/Ampfile'
    end

    it 'should be relative to current directory' do
      subject.relative_join('Ampfile', '/path/subdir').should == 'subdir/Ampfile'
    end

    it 'should remove the root path' do
      subject.relative_join('Ampfile', '/path/subdir').should == 'subdir/Ampfile'
    end
  end
end
