shared_examples_for 'staging_area#find_with_patterns' do
  it {should respond_to :find_with_patterns}

  describe 'when in a new repo' do
    in_a_new_repo do
      create 'unknown.file'
      add 'new.file'
      create 'dir/sub.file'
      add 'new/sub.file'
    end
    subject do
      files, dirs = repo.staging_area.examine_named_files([
        'unknown.file',
        'new.file',
        'dir',
        'new'
      ], Amp::Match.new)
      repo.staging_area.find_with_patterns(files, dirs, Amp::Match.new)
    end
    it {subject['unknown.file'].should be}
    it {subject['new.file'].should be}
    it {subject['dir/sub.file'].should be}
    it {subject['new/sub.file'].should be}
  end

  describe 'when in an existing repo' do
    in_a_new_repo do
      add 'existing.file'
      add 'removed.file'
      add 'deleted.file'
      add 'sub/del.file'
      add 'sub/rem.file'
      commit
      remove 'removed.file'
      delete 'deleted.file'
      remove 'sub/rem.file'
      delete 'sub/del.file'
      delete 'sub'
    end
    subject do
      files, dirs = repo.staging_area.examine_named_files([
        'existing.file',
        'removed.file',
        'deleted.file',
        'sub',
      ], Amp::Match.new)
      repo.staging_area.find_with_patterns(files, dirs, Amp::Match.new)
    end
    it {should have(3).items}
    its(:keys) {should include('existing.file')}
    its(:keys) {should include('removed.file')}
    # and the vcs dir
  end

  pending 'ignored'
  pending 'depreciated?'
end
