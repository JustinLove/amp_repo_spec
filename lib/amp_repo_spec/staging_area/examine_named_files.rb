shared_examples_for 'staging_area#examine_named_files' do
  it {should respond_to :examine_named_files}

  describe 'when in a new repo' do
    in_a_new_repo do
      create 'unknown.file'
      add 'new.file'
      create 'dir/sub.file'
      add 'new/sub.file'
    end
    describe '[]' do
      subject {repo.staging_area.examine_named_files([], Amp::Match.new)}
      it {subject.first.keys.should have(1).items}
      it {subject.last.should be_empty}
    end
    describe 'nonexistant.file' do
      subject {repo.staging_area.examine_named_files(['nonexistant.file'], Amp::Match.new)}
      it {subject.first.keys.should have(2).items}
      it {subject.first['nonexistant.file'].should be_nil}
      it {subject.last.should be_empty}
    end
    describe 'unknown.file' do
      subject {repo.staging_area.examine_named_files(['unknown.file'], Amp::Match.new)}
      it {subject.first.keys.should have(2).items}
      it {subject.first['unknown.file'].should be}
      it {subject.last.should be_empty}
    end
    describe 'new.file' do
      subject {repo.staging_area.examine_named_files(['new.file'], Amp::Match.new)}
      it {subject.first.keys.should have(2).items}
      it {subject.first['new.file'].should be}
      it {subject.last.should be_empty}
    end
    describe 'dir' do
      subject {repo.staging_area.examine_named_files(['dir'], Amp::Match.new)}
      it {subject.first.keys.should have(1).items}
      it {subject.last.should have(1).items}
      it {subject.last.first.should =~ /dir$/}
    end
    describe 'new' do
      subject {repo.staging_area.examine_named_files(['new'], Amp::Match.new)}
      it {subject.first.keys.should have(1).items}
      it {subject.last.first.should =~ /new$/}
    end
    describe 'new/sub.file' do
      subject {repo.staging_area.examine_named_files(['new/sub.file'], Amp::Match.new)}
      it {subject.first.keys.should have(2).items}
      it {subject.last.should have(0).items}
    end
    describe 'multiple' do
      subject {repo.staging_area.examine_named_files(['dir', 'new/sub.file'], Amp::Match.new)}
      it {subject.first.keys.should have(2).items}
      it {subject.last.should have(1).items}
    end
  end

  describe 'when in an existing repo', :focus => true do
    in_a_new_repo do
      add 'existing.file'
      add 'removed.file'
      add 'deleted.file'
      add 'sub/del.file'
      commit
      remove 'removed.file'
      delete 'deleted.file'
      delete 'sub/del.file'
      delete 'sub'
    end
    describe 'existing.file' do
      subject {repo.staging_area.examine_named_files(['existing.file'], Amp::Match.new)}
      it {subject.first.keys.should have(2).items}
      it {subject.first['existing.file'].should be}
      it {subject.last.should be_empty}
    end
    describe 'removed.file' do
      subject {repo.staging_area.examine_named_files(['removed.file'], Amp::Match.new)}
      it {subject.first.keys.should have(2).items}
      it {subject.first['removed.file'].should be_nil}
      it {subject.last.should be_empty}
    end
    describe 'deleted.file' do
      subject {repo.staging_area.examine_named_files(['deleted.file'], Amp::Match.new)}
      it {subject.first.keys.should have(1).items}
      it {subject.last.should be_empty}
    end
    describe 'sub' do
      subject {repo.staging_area.examine_named_files(['sub'], Amp::Match.new)}
      it {subject.first.keys.should have(1).items}
      it {subject.last.should be_empty}
    end
  end
end
