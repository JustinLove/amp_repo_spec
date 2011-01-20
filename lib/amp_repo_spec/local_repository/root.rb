shared_examples_for 'local_repository#root' do
  it {should respond_to :root}

  its(:root) {should == tempdir}
end
