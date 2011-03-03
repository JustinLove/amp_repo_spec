shared_examples_for 'changeset#all_files' do
  it {should respond_to :all_files}

  describe "committing one file" do
    $node = ''
    in_a_new_repo do
      add 'some.file'
      create 'unknown.file'
      $node = commit
    end
    subject {described_class.new(repo, $node).all_files}
    it {should == ['some.file']}
  end

  describe "commiting multiple files" do
    $node = ''
    in_a_new_repo do
      add 'a.file'
      add 'b.file'
      add 'c.file'
      $node = commit
    end
    subject {described_class.new(repo, $node).all_files}
    it {subject.sort.should == ['a.file', 'b.file', 'c.file']}
  end

  describe "files from multiple revisions" do
    $node = ''
    in_a_new_repo do
      add 'some.file'
      commit
      add 'another.file'
      $node = commit
    end
    subject {described_class.new(repo, $node).all_files}
    it {subject.sort.should == ['another.file', 'some.file']}
  end
end
