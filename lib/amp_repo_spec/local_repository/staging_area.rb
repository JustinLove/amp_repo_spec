require 'amp_repo_spec/staging_area/quack'

shared_examples_for 'local_repository#staging_area' do
  it {should respond_to :staging_area}
  its(:staging_area) {should be}
  its(:staging_area) {should quack_like AmpRepoSpec::AStagingArea}
end
