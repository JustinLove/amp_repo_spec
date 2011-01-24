shared_examples_for 'staging_area#file_status' do
  it {should respond_to :file_status}

  describe 'when in a brand new repository' do
    in_a_new_directory
    subject {repo.staging_area}
    before(:all) do
      repo.init
      @path.file('amp/untracked.file')
    end

    it { subject.file_status('nonexistant.file').should be_nil }
    it { subject.file_status('untracked.file').should == :untracked }
  end

  pending 'all the rest of the statuses'
end
