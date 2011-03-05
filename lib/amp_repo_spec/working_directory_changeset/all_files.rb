shared_examples_for 'working_directory_changeset#all_files' do
  it {should respond_to :all_files}

  describe 'empty repo' do
    in_a_new_repo
    subject {described_class.new(repo).all_files}
    it {should == ['Ampfile']}
  end

  describe 'no commits' do
    in_a_new_repo do
      add 'some.file'
    end
    subject {described_class.new(repo).all_files}
    it {should == ['Ampfile']}
  end

  describe 'listing multiple files' do
    in_a_new_repo do
      create 'a.file'
      create 'b.file'
    end
    subject {described_class.new(repo).all_files}
    it {subject.sort.should == ['Ampfile', 'a.file', 'b.file']}
  end

  describe 'files from multiple revisions' do
    in_a_new_repo do
      add 'some.file'
      commit
      add 'another.file'
      create 'new.file'
    end
    subject {described_class.new(repo).all_files}
    it {subject.sort.should == ['Ampfile', 'new.file']}
  end

  describe 'removed files' do
    in_a_new_repo do
      add 'some.file'
      add 'another.file'
      add 'ghost.file'
      commit
      remove 'some.file'
      delete 'another.file'
      remove 'ghost.file'
      create 'ghost.file'
    end
    subject {described_class.new(repo).all_files}
    it {subject.sort.should == ['Ampfile', 'ghost.file']}
  end
end
