require 'amp_repo_spec/amp_spec_helper'

shared_examples_for 'local repository' do
  include AmpRepoSpec::Helper
  
  subject {described_class.new(tempdir)}

  Dir.glob(File.join(File.dirname(__FILE__), 'local_repository/*.rb')).each do |file|
    require file
    it_should_behave_like 'local_repository#' + File.basename(file, '.rb')
  end
end
