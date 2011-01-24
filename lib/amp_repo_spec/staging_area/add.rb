shared_examples_for 'staging_area#add' do
  it {should respond_to :add}

  describe 'should add files in a brand new repository' do
    in_a_new_directory
    subject {repo.staging_area}
    before(:all) do
      repo.init
      @path.file('amp/untracked.file')
      @path.file('amp/tracked.file')
      subject.add('tracked.file')
    end

    it { subject.tracking?('untracked.file').should_not be_true }
    it { subject.tracking?('tracked.file').should be_true }
  end
end
