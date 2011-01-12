shared_examples_for 'local_repository#remove' do
  it {should respond_to :remove}

  let(:staging_area) { double('staging_area') }
  before { subject.stub(:staging_area).and_return(staging_area) }

  it "passes remove to staging area" do
    staging_area.should_receive(:remove).with("file")
    subject.remove("file")
  end
end
