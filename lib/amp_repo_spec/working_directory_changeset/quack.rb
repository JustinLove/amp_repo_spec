require 'amp_repo_spec/changeset/quack'
shared_examples_for "working_directory_changeset#quack" do
  it {should quack_like AmpRepoSpec::AChangeset}
end
