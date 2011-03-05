shared_examples_for 'staging_area#tracking' do
  it {should respond_to :tracking?}

  describe 'when in a brand new repository' do
    in_a_new_repo do
      create 'untracked.file'
      add 'tracked.file'
    end
    subject {repo.staging_area}

    it { should_not be_tracking('nonexistant.file') }
    it { should_not be_tracking('untracked.file') }
    it { should     be_tracking('tracked.file') }
  end

  describe 'when in a repo with tracked files' do
    in_a_new_repo do
      add 'unmodified.file'
      add 'modified.file'
      add 'deleted.file'
      add 'removed.file'
      commit
      modify 'modified.file'
      remove 'removed.file'
      delete 'deleted.file'
      create 'new.file'
    end
    subject {repo.staging_area}

    it { should     be_tracking('unmodified.file') }
    it { should     be_tracking('modified.file') }
    it { should     be_tracking('deleted.file') }
    it { should_not be_tracking('removed.file') }
    it { should_not be_tracking('new.file') }
  end

  describe 'when in a repo with history' do
    in_a_new_repo do
      add 'previously.removed'
      commit
      remove 'previously.removed'
      commit
    end
    subject {repo.staging_area}

    it { should_not be_tracking('previously.removed') }
  end
end
