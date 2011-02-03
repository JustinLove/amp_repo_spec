shared_examples_for 'staging_area#file_status' do
  it {should respond_to :file_status}

  def self.sees(file, status)
    it("#{file} -> #{status}") { subject.file_status(file).should == status }
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

    sees('nonexistant.file', nil)
    sees('untracked.file', :untracked)
    sees('tracked.file', :added)
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

    sees('unmodified.file', :normal)
    sees('modified.file', :modified)
    sees('deleted.file', :deleted)
    sees('removed.file', :deleted)
    sees('new.file', :untracked)
  end
end
