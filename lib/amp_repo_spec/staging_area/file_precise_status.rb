shared_examples_for 'staging_area#file_precise_status' do
  it {should respond_to :file_precise_status}

  RSpec::Matchers.define :fps_as do |status|
    match do |file|
      stat = File.lstat('amp/'+file) if File.exist?('amp/'+file)
      subject.file_precise_status(file, stat) == status
    end
    failure_message_for_should do |file|
      stat = File.lstat('amp/'+file) if File.exist?('amp/'+file)
      "expected #{file} to be #{status}, got #{subject.file_precise_status(file, stat)}"
    end
  end

  describe 'when in a brand new repository' do
    in_a_new_repo do
      create 'untracked.file'
      add 'tracked.file'
    end
    subject {repo.staging_area}

    it {'nonexistant.file'.should fps_as(:clean)}
    it {'untracked.file'.should fps_as(:clean)}
    it {'tracked.file'.should fps_as(:clean)}
  end

  describe 'when in a repo with tracked files' do
    in_a_new_repo do
      add 'unmodified.file'
      add 'modified.file'
      add 'included.file'
      add 'deleted.file'
      add 'removed.file'
      commit
      remove 'removed.file'
      delete 'deleted.file'
      modify 'modified.file'
      modify 'included.file'
      repo.staging_area.include 'included.file'
      create 'new.file'
    end
    subject {repo.staging_area}

    it {'unmodified.file'.should fps_as(:clean)}
    it {'modified.file'.should fps_as(:clean)}
    it {'included.file'.should fps_as(:modified)}
    it {'deleted.file'.should fps_as(:clean)}
    it {'removed.file'.should fps_as(:clean)}
    it {'new.file'.should fps_as(:clean)}
  end

  describe 'when in a repo with history' do
    in_a_new_repo do
      add 'previously.removed'
      commit
      remove 'previously.removed'
      commit
    end
    subject {repo.staging_area}

    it {'previously.removed'.should fps_as(:clean)}
  end
end
