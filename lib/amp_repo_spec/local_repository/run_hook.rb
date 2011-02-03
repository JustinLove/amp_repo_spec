shared_examples_for 'local_repository#run_hook' do
  it {should respond_to :run_hook}

  describe "with mocked hook" do
    let(:hook) {Amp::Hook = double('hook')}

    it "runs a hook with opts" do
      hook.should_receive(:run_hook).with(:call, {:foo => :bar})
      subject.run_hook(:call, {:foo => :bar})
    end

    it "runs a hook without opts" do
      hook.should_receive(:run_hook).with(:call, {:throw=>false})
      subject.run_hook(:call)
    end
  end
end
