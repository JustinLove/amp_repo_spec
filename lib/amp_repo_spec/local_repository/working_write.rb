shared_examples_for 'local_repository#working_write' do
  it {should respond_to :working_write}

  in_a_new_directory

  it "should write to a new file" do
    subject.working_write("new.file", "something")
    p subject.root, Dir.getwd
    File.exist?("amp/new.file").should be_true
  end

  it "should write to an existing file" do
    @path.file("amp/old.file")
    subject.working_write("old.file", "something else")
    File.read("amp/old.file").should == "something else"
  end
end
