shared_examples_for 'staging_area#all_files' do
  it {should respond_to :all_files}

  describe 'in a new repository', :focus => true do
    in_a_new_repo
    subject {repo.staging_area.all_files}
    it {should be_empty}
  end

  describe 'in a modified repository', :focus => true do
    in_a_new_repo do
      add 'unmodified.file'
      add 'modified.file'
      add 'removed.file'
      add 'deleted.file'
      commit
      add 'new.file'
      modify 'modified.file'
      remove 'removed.file'
      delete 'deleted.file'
      create 'mystery.file'
    end
    subject {repo.staging_area.all_files}

    it {should include('unmodified.file')}
    it {should include('modified.file')}
    it {should_not include('removed.file')}
    it {should include('deleted.file')}
    it {should include('new.file')}
    it {should_not include('mystery.file')}
  end
end
