require 'tmpdir'

module AmpRepoSpec::Helper
  def self.included(into)
    into.before(:all) do
      tmpdir = nil
      Dir.chdir Dir.tmpdir do tmpdir = Dir.pwd end # HACK OSX /private/tmp
      @tempdir = File.join tmpdir, "test_amp_#{$$}"
      @tempdir.untaint
    end

    into.after(:all) do
      FileUtils.rm_rf @tempdir if defined?(@tempdir) && @tempdir && File.exist?(@tempdir)
    end
  end

  def tempdir
    @tempdir
  end
end
