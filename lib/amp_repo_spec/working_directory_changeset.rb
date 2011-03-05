require 'amp_repo_spec/amp_spec_helper'

shared_examples_for 'working_directory_changeset' do
  include AmpRepoSpec::Helper
  
  let(:repo) {ModuleUnderTest::LocalRepository.new(tempdir)}
  subject {described_class.new(repo)}

  Dir.glob(File.join(File.dirname(__FILE__), 'working_directory_changeset/*.rb')).each do |file|
    require file
    it_should_behave_like 'working_directory_changeset#' + File.basename(file, '.rb')
  end
end
