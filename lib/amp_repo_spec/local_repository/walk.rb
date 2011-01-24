shared_examples_for 'local_repository#walk' do
  it {should respond_to :walk}

  let(:match_all) do
    m = double('match all')
    def m.files; []; end
    def m.call(*args); true; end
    m
  end

  let(:match_none) do
    m = double('match none')
    def m.files; []; end
    def m.call(*args); false; end
    m
  end

  before do
    Amp::Match = double('Match')
    Amp::Match.stub(:create).and_return(match_all)
    Amp::Match.stub(:new).and_return(match_all)
  end

  in_a_new_directory
  subject {repo}

  before(:all) {subject.init}
  its(:walk) {should include('Ampfile')}

  it "should use a matcher" do
    subject.walk(nil, match_none).should == []
  end

  pending 'walk with a revision'
end
