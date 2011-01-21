shared_examples_for 'local_repository#file_modified' do
  it {should respond_to :file_modified?}

  describe "in a new repo" do
    in_a_new_directory

    before(:all) do
      subject.init
      @the_file = 'the.file'
      @path.file(@the_file)
      subject.add(@the_file)
    end

    xit "is added, not modified" do
      subject.file_modified?(@the_file).should be_false
    end
  end

  describe "after committing" do
    in_a_new_directory

    before(:all) do
      subject.init
      @the_file = 'the.file'
      @path.file(@the_file)
      subject.add(@the_file)
      #subject.commit
    end

    xit "should not be modified" do
      subject.file_modified?(@the_file).should be_false
    end
  end

  describe "after changes" do
    in_a_new_directory

    before(:all) do
      subject.init
      @the_file = 'the.file'
      @path.file(@the_file)
      subject.add(@the_file)
      #subject.commit

      @path.file(@the_file) do |file|
        file << 'foo'
      end
    end

    xit "should be modified" do
      subject.file_modified?(@the_file).should be_true
    end
  end
end
