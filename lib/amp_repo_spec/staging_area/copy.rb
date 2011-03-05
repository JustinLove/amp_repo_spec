shared_examples_for 'staging_area#copy' do
  it {should respond_to :copy}

  describe 'copy' do
    in_a_new_repo do
      add 'some.file'
      commit
      repo.staging_area.copy 'some.file', 'copy.file'
    end
    describe 'vcs' do
      subject {repo.staging_area}
      it {subject.file_status('some.file').should == :normal}
      it {subject.file_status('copy.file').should == :added}
    end
    describe 'filesystem' do
      subject {File}
      it {should be_exist('amp/some.file')}
      it {should be_exist('amp/copy.file')}
    end
  end
end
