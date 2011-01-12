shared_examples_for 'local_repository#config' do
  it {should respond_to :config}

  describe 'with no config specified' do
    its(:config) {should be_nil}
  end

  describe 'with a config specified' do
    let :options do {:ye => :ha} end
    subject {described_class.new("", nil, options)}
    its(:config) {should == options}
  end
end
