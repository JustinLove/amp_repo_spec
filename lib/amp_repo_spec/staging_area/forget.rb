shared_examples_for 'staging_area#forget' do
  it {should respond_to :forget}

  describe 'forget' do
    in_a_new_repo do
      add 'removed.file'
      commit
      add 'new.file'
      repo.staging_area.forget 'removed.file'
      repo.staging_area.forget 'new.file'
    end
    describe 'vcs' do
      subject {repo.staging_area}
      it {subject.file_status('removed.file').should == :removed}
      it {subject.file_status('new.file').should == nil}
    end
    describe 'filesystem' do
      subject {File}
      it {should be_exist('amp/removed.file')}
      it {should be_exist('amp/new.file')}
    end
  end
end
