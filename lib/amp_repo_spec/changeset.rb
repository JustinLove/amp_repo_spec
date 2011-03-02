require 'amp_repo_spec/amp_spec_helper'

shared_examples_for 'changeset' do
  include AmpRepoSpec::Helper
  
  let(:repo) {ModuleUnderTest::LocalRepository.new(tempdir)}
  subject {described_class.new(repo, nil)}

  Dir.glob(File.join(File.dirname(__FILE__), 'changeset/*.rb')).each do |file|
    require file
    it_should_behave_like 'changeset#' + File.basename(file, '.rb')
  end
end
