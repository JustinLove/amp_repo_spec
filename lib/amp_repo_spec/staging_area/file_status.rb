shared_examples_for 'staging_area#file_status' do
  it {should respond_to :file_status}

  RSpec::Matchers.define :stat_as do |status|
    match do |file|
      subject.file_status(file) == status
    end
    failure_message_for_should do |file|
      "expected #{file} to be #{status}, got #{subject.file_status(file)}"
    end
  end

  Amp::Hook = Object.new
  class << Amp::Hook
    def run_hook(*args)
    end
  end


  describe 'when in a brand new repository' do
    in_a_new_repo do
      create 'untracked.file'
      add 'tracked.file'
    end
    subject {repo.staging_area}

    it {'nonexistant.file'.should stat_as(nil)}
    it {'untracked.file'.should stat_as(:untracked)}
    it {'tracked.file'.should stat_as(:added)}
  end

  describe 'when in a repo with tracked files' do
    in_a_new_repo do
      add 'unmodified.file'
      add 'modified.file'
      add 'deleted.file'
      add 'removed.file'
      commit
      remove 'removed.file'
      delete 'deleted.file'
      modify 'modified.file'
      create 'new.file'
    end
    subject {repo.staging_area}

    it {'unmodified.file'.should stat_as(:normal)}
    it {'modified.file'.should stat_as(:modified)}
    it {'deleted.file'.should stat_as(:deleted)}
    it {'removed.file'.should stat_as(:deleted)}
    it {'new.file'.should stat_as(:untracked)}
  end

  describe 'when in a repo with history' do
    in_a_new_repo do
      add 'previously.removed'
      commit
      remove 'previously.removed'
      commit
    end
    subject {repo.staging_area}

    it {'previously.removed'.should stat_as(nil)}
  end
end
