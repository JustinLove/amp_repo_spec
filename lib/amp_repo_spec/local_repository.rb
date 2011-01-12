local_repository_methods = %w{
  config
  staging_area
  init
}

local_repository_methods.each do |meth|
  require 'amp_repo_spec/local_repository/' + meth
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
