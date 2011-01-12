shared_examples_for 'LocalRepository#working_join' do
  it {should respond_to :working_join}
  subject {described_class.new('/path')}

  it('prepends working directory') {subject.working_join('Ampfile').should == ('/path/Ampfile')}
end
