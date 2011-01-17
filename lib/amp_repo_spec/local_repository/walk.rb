shared_examples_for 'local_repository#walk' do
  it {should respond_to :walk}

  let(:match_all) do
    m  = double('match')
    m.stub(:call).and_return(true)
    m.stub(:files).and_return([])
    m
  end

  let(:match_none) do
    m  = double('match')
    m.stub(:call).and_return(false)
    m.stub(:files).and_return([])
    m
  end

  before do
    Amp::Match = double('Match')
    Amp::Match.stub('create').and_return(match_all)
  end

  in_a_new_directory

  before(:all) {subject.init}
  its(:walk) {should include('Ampfile')}

  it "should use a matcher" do
    subject.walk(nil, match_none).should == []
  end

  pending 'walk with a revision'
end
