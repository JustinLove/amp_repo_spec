shared_examples_for 'staging_area#exclude' do
  it {should respond_to :exclude}

  describe 'exclude' do
    in_a_new_repo do
      add 'excluded.file'
      add 'normal.file'
      commit
      modify 'excluded.file'
      repo.staging_area.include 'excluded.file'
      repo.staging_area.exclude 'excluded.file'
    end
    subject {repo.staging_area}
    it {subject.file_status('excluded.file').should == :normal}
    it {subject.file_status('normal.file').should == :normal}
    it {expect {subject.exclude 'normal.file'}.to_not raise_error}
  end
end
