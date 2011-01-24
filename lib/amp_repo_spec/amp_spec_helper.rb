require 'tmpdir'
require 'construct'

module AmpRepoSpec::Helper
  include Construct::Helpers
  def self.included(into)
    into.before(:all) do
      @basedir = Dir.getwd
      @construct = create_construct
      Dir.chdir @construct.to_s
      @tempdir = File.join @construct.to_s, "test_amp_#{$$}"
      @tempdir.untaint
    end

    into.after(:all) do
      @construct.destroy! if defined?(@construct) && @construct
      Dir.chdir @basedir
    end

    into.extend ClassMethods
  end

  attr_accessor :construct
  attr_accessor :tempdir

  module ClassMethods
    include Construct::Helpers
    def in_a_new_directory
      oldpath = Dir.getwd
      newpath = create_construct
      before(:all) do
        Dir.chdir newpath.to_s
        @path = newpath
      end
      after(:all) do
        Dir.chdir oldpath
        newpath.destroy!
      end
      let(:repo) {ModuleUnderTest::LocalRepository.new(newpath.to_s + '/amp')}
    end
  end
end
