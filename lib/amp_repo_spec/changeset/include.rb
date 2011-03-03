shared_examples_for 'changeset#include' do
  it {should respond_to :include?}

  describe "empty repo" do
    in_a_new_repo
    subject {described_class.new(repo, :tip)}
    it {subject.include?('some.file').should be_false}
  end

  describe "committing one file" do
    $node = ''
    in_a_new_repo do
      add 'some.file'
      create 'unknown.file'
      $node = commit
    end
    subject {described_class.new(repo, $node)}
    it {subject.include?('some.file').should be_true}
    it {subject.include?('unknown.file').should be_false}
  end

  describe "files from multiple revisions" do
    $node = ''
    in_a_new_repo do
      add 'some.file'
      commit
      add 'another.file'
      remove 'some.file'
      $node = commit
    end
    subject {described_class.new(repo, $node)}
    it {subject.include?('another.file').should be_true}
    it {subject.include?('some.file').should be_false}
  end

  describe "files from previous revisions" do
    $node = ''
    in_a_new_repo do
      add 'some.file'
      $node = commit
      add 'another.file'
      remove 'some.file'
      commit
    end
    subject {described_class.new(repo, $node)}
    it {subject.include?('another.file').should be_false}
    it {subject.include?('some.file').should be_true}
  end
end
