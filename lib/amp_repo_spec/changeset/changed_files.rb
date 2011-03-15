shared_examples_for 'changeset#changed_files' do
  it {should respond_to :changed_files}

  describe "empty repo" do
    in_a_new_repo
    subject {described_class.new(repo, :tip).changed_files}
    it {should be_empty}
  end

  describe "committing" do
    $node = ''
    in_a_new_repo do
      add 'modified.file'
      add 'unmodified.file'
      add 'removed.file'
      commit
      add 'new.file'
      include modify 'modified.file'
      remove 'removed.file'
      $node = commit
    end
    subject {described_class.new(repo, $node).changed_files}
    pending {subject['new.file'].should be}
    pending {subject['modified.file'].should be}
    pending {subject['unmodified.file'].should_not be}
    pending {subject['removed.file'].should be}
  end
end
