shared_examples_for 'local_repository#add' do
  it {should respond_to :add}

  let(:staging_area) { double('staging_area') }
  before { subject.stub(:staging_area).and_return(staging_area) }

  it "passes add to staging area" do
    staging_area.should_receive(:add).with("file")
    subject.add("file")
  end
end
