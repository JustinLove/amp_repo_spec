require 'amp_repo_spec/staging_area/quack'

shared_examples_for 'local repository staging area' do
  it {should respond_to :staging_area}
  its(:staging_area) {should be}
  it_should_behave_like 'a staging area duck', described_class.new.staging_area
end
