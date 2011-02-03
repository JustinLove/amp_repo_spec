require 'tmpdir'
require 'construct'

module AmpRepoSpec::Helper
  include Construct::Helpers
  def self.included(into)
    into.before(:all) do
      install_stubs
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

  module Stubs
    class Hook
      def self.run_hook(*args)
      end
    end
    class Match
      def self.create(*args); new; end
      def call(*args); true; end
      def files; []; end
    end
  end
  def install_stubs
    Amp.const_set(:Hook, Stubs::Hook) if Amp::Hook != Stubs::Hook
    Amp.const_set(:Match, Stubs::Match) if Amp::Match != Stubs::Match
  end

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
