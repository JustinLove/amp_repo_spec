require 'amp_repo_spec/amp_spec_helper'

shared_examples_for 'staging_area' do
  include AmpRepoSpec::Helper
  
  #subject {described_class.new(ModuleUnderTest::LocalRepository.new(tempdir))}

  Dir.glob(File.join(File.dirname(__FILE__), 'staging_area/*.rb')).each do |file|
    require file
    p "(#{Dir.getwd})"
    it_should_behave_like 'staging_area#' + File.basename(file, '.rb')
  end
end
