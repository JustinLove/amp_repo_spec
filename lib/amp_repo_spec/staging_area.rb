require 'amp_repo_spec/amp_spec_helper'

shared_examples_for 'staging_area' do
  include AmpRepoSpec::Helper
  
  let(:repo) {ModuleUnderTest::LocalRepository.new(tempdir)}
  subject {described_class.new(repo)}

  Dir.glob(File.join(File.dirname(__FILE__), 'staging_area/*.rb')).each do |file|
    require file
    it_should_behave_like 'staging_area#' + File.basename(file, '.rb')
  end
end
