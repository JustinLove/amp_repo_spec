shared_examples_for 'local_repository#init' do
  it {should respond_to :init}

  RSpec::Matchers.define :be_a_directory do
    match do |actual|
      File.directory?(actual)
    end
  end

  RSpec::Matchers.define :contain_the_file do |file|
    match do |actual|
      File.exist?(File.join(actual, file))
    end
  end

  in_a_new_directory

  describe "before init" do
    its(:root) {should_not be_a_directory}
    its(:root) {should_not contain_the_file('Ampfile')}
  end

  describe "after init" do
    before(:all) {subject.init}
    its(:root) {should be_a_directory}
    its(:root) {should contain_the_file('Ampfile')}
  end
end
