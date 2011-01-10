local_repository_methods = %w{
  config
  staging_area
}

local_repository_methods.each do |meth|
  require 'amp_repo_spec/local_repository/' + meth
end

shared_examples_for 'local repository' do
  it {should be_kind_of(Enumerable)}
  local_repository_methods.each do |meth|
    it_should_behave_like 'LocalRepository#' + meth
  end
end
