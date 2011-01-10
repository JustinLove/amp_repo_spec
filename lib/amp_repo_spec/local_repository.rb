require 'amp_repo_spec/local_repository/config'
require 'amp_repo_spec/local_repository/staging_area'

shared_examples_for 'local repository' do
  it {should be_kind_of(Enumerable)}
  it_should_behave_like 'local repository config'
  it_should_behave_like 'local repository staging area'
end
