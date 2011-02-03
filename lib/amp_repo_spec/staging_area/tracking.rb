shared_examples_for 'staging_area#tracking' do
  it {should respond_to :tracking?}

  describe 'when in a brand new repository' do
    in_a_new_directory
    subject {repo.staging_area}
    before(:all) do
      repo.init
      @path.file('amp/untracked.file')
      @path.file('amp/tracked.file')
      repo.add('tracked.file')
    end

    it { should_not be_tracking('nonexistant.file') }
    it { should_not be_tracking('untracked.file') }
    it { should     be_tracking('tracked.file') }
  end

  describe 'when in a repo with tracked files' do
    in_a_new_directory
    subject {repo.staging_area}
    before(:all) do
      repo.init
      @path.file('amp/unmodified.file')
      repo.add('unmodified.file')
      @path.file('amp/modified.file')
      repo.add('modified.file')
      @path.file('amp/deleted.file')
      repo.add('deleted.file')
      @path.file('amp/removed.file')
      repo.add('removed.file')
      repo.commit(:message => 'stuff')
      @path.file('amp/modified.file') {|file| file << 'stuff' }
      repo.remove('removed.file')
      File.delete('amp/deleted.file')
      @path.file('amp/new.file')
      subject.refresh!
    end

    it { should     be_tracking('unmodified.file') }
    it { should     be_tracking('modified.file') }
    it { should     be_tracking('deleted.file') }
    it { should     be_tracking('removed.file') }
    it { should_not be_tracking('new.file') }
  end

  describe 'when in a repo with history' do
    in_a_new_directory
    subject {repo.staging_area}
    before(:all) do
      repo.init
      @path.file('amp/previously.removed')
      repo.add('previously.removed')
      repo.commit(:message => 'stuff')
      subject.refresh!
      repo.remove('previously.removed')
      repo.commit(:message => 'stuff')
      subject.refresh!
    end

    it { should_not be_tracking('previously.removed') }
  end
end
