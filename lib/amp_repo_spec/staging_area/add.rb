shared_examples_for 'staging_area#add' do
  it {should respond_to :add}

  describe 'should add files in a brand new repository' do
    in_a_new_repo do
      create 'untracked.file'
      add 'tracked.file'
    end
    subject {repo.staging_area}

    it { subject.tracking?('untracked.file').should_not be_true }
    it { subject.tracking?('tracked.file').should be_true }
  end
end
