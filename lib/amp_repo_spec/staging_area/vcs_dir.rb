shared_examples_for 'staging_area#vcs_dir' do
  it {should respond_to :vcs_dir}
  its(:vcs_dir) {should be_kind_of(String)}
end
