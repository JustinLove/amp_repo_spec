shared_examples_for 'staging_area#move' do
  it {should respond_to :move}

  describe 'move' do
    in_a_new_repo do
      add 'some.file'
      commit
      repo.staging_area.move 'some.file', 'move.file'
    end
    describe 'vcs' do
      subject {repo.staging_area}
      it {subject.file_status('some.file').should == :removed}
      it {subject.file_status('move.file').should == :added}
    end
    describe 'filesystem' do
      subject {File}
      it {should_not be_exist('amp/some.file')}
      it {should     be_exist('amp/move.file')}
    end
  end
end
