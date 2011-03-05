shared_examples_for 'staging_area#normal' do
  it {should respond_to :normal}

  describe 'normal' do
    in_a_new_repo do
      add 'removed.file'
      add 'modified.file'
      commit
      remove 'removed.file'
      modify 'modified.file'
      add 'new.file'
      repo.staging_area.normal 'removed.file'
      repo.staging_area.normal 'modified.file'
      repo.staging_area.normal 'new.file'
    end
    subject {repo.staging_area}
    pending {subject.file_status('removed.file').should == :normal}
    pending {subject.file_status('modified.file').should == :normal}
    pending {subject.file_status('new.file').should == :normal}
  end
end
