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
    in_a_new_directory
    subject {repo.staging_area}
    before(:all) do
      repo.init
      @path.file('amp/untracked.file')
      @path.file('amp/tracked.file')
      repo.add('tracked.file')
    end

    it {'nonexistant.file'.should stat_as(nil)}
    it {'untracked.file'.should stat_as(:untracked)}
    it {'tracked.file'.should stat_as(:added)}
  end

  describe 'when in a repo with tracked files' do
    in_a_new_directory
    subject {repo.staging_area}
    before(:all) do
      Amp::Hook = Object.new
      class << Amp::Hook
        def run_hook(*args)
        end
      end
      Amp::Match = Class.new
      class Amp::Match
        def self.create(*args); new; end
        def call(*args); true; end
        def files; []; end
      end
      repo.init
      @path.file('amp/unmodified.file')
      repo.add('unmodified.file')
      @path.file('amp/modified.file')
      repo.add('modified.file')
      @path.file('amp/deleted.file')
      repo.add('deleted.file')
      @path.file('amp/removed.file')
      repo.add('removed.file')
      repo.commit(:message => 'stuff')
      @path.file('amp/modified.file') {|file| file << 'stuff' }
      repo.remove('removed.file')
      File.delete('amp/deleted.file')
      @path.file('amp/new.file')
      subject.refresh!
    end

    it {'unmodified.file'.should stat_as(:normal)}
    it {'modified.file'.should stat_as(:modified)}
    it {'deleted.file'.should stat_as(:deleted)}
    it {'removed.file'.should stat_as(:deleted)}
    it {'new.file'.should stat_as(:untracked)}
  end
end
