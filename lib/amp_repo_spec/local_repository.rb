local_repository_methods = []

Dir.glob(File.join(File.dirname(__FILE__), 'local_repository/*.rb')).each do |file|
  require file
  local_repository_methods << File.basename(file, '.rb') 
end

require 'amp_repo_spec/amp_spec_helper'

shared_examples_for 'local repository' do
  include AmpRepoSpec::Helper
  
  subject {described_class.new(tempdir)}
  it {should be_kind_of(Enumerable)}
  local_repository_methods.each do |meth|
    it_should_behave_like 'LocalRepository#' + meth
  end
end
