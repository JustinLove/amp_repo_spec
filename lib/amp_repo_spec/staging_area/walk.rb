shared_examples_for 'staging_area#walk' do
  it {should respond_to :walk}

  def show(x); true; end
  def hide(x); false; end

  describe 'when in a new repo' do
    in_a_new_repo do
      create 'unknown.file'
      add 'new.file'
      create 'dir/sub.file'
      add 'new/sub.file'
    end
    describe "show unknown, show ignored" do
      subject {repo.staging_area.walk(show(:unknown), show(:ignored))}
      it {subject['unknown.file'].should be}
      it {subject['new.file'].should be}
      it {subject['dir/sub.file'].should be}
      it {subject['new/sub.file'].should be}
    end
    describe "hide unknown, show ignored" do
      subject {repo.staging_area.walk(hide(:unknown), show(:ignored))}
      it {subject['unknown.file'].should_not be}
      it {subject['new.file'].should be}
      it {subject['dir/sub.file'].should_not be}
      it {subject['new/sub.file'].should be}
    end
    pending 'ignored'
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
    end
    subject {repo.staging_area.walk(hide(:unknown), show(:ignored))}
    it {subject['existing.file'].should be}
    it {subject['removed.file'].should_not be}
    pending {subject['deleted.file'].should be}
    pending {subject['sub/del.file'].should be}
    it {subject['sub/rem.file'].should_not be}
  end

  pending 'depreciated?'
end
