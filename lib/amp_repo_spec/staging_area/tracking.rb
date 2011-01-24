shared_examples_for 'staging_area#tracking' do
  it {should respond_to :tracking?}

  describe 'when in a brand new repository' do
    in_a_new_directory
    subject {repo.staging_area}
    before(:all) do
      repo.init
      @path.file('amp/untracked.file')
    end

    it { subject.tracking?('nonexistant.file').should_not be_true }
    it { subject.tracking?('untracked.file').should_not be_true }
  end

  pending 'other file status'
end
