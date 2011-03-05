shared_examples_for 'staging_area#remove' do
  it {should respond_to :remove}

  describe 'remove previously committed files' do
    in_a_new_repo do
      add 'tracked.file'
      commit
      remove 'tracked.file'
      add 'new.file'
      remove 'new.file'
    end
    subject {repo.staging_area}

    it { subject.should_not be_tracking('tracked.file')}
    it { subject.should_not be_tracking('new.file')}
  end
end
