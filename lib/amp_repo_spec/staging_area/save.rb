shared_examples_for 'staging_area#save' do
  it {should respond_to :save}

  describe 'save' do
    in_a_new_repo do
      add 'new.file'
      repo.staging_area.save
    end
    subject {ModuleUnderTest::LocalRepository.new(repo.root).staging_area}
    it {subject.file_status('new.file').should == :added}
  end
end
