shared_examples_for 'local_repository#file_modified' do
  it {should respond_to :file_modified?}

  describe "in a new repo" do
    in_a_new_directory
    subject {repo}

    before(:all) do
      subject.init
      @the_file = 'the.file'
      @path.file('amp/the.file')
      subject.add(@the_file)
      subject.refresh!
    end

    it "is added, not modified" do
      subject.file_modified?(@the_file).should be_false
    end
  end

  describe "after committing" do
    in_a_new_directory
    subject {repo}

    before(:all) do
      subject.init
      @the_file = 'the.file'
      @path.file('amp/the.file')
      subject.add(@the_file)
      subject.commit(:message => 'stuff')
      subject.refresh!
    end

    it "should not be modified" do
      subject.file_modified?(@the_file).should be_false
    end
  end

  describe "after changes" do
    in_a_new_directory
    subject {repo}

    before(:all) do
      subject.init
      @the_file = 'the.file'
      @path.file('amp/the.file')
      subject.add(@the_file)
      subject.commit(:message => 'stuff')

      @path.file('amp/the.file') do |file|
        file << 'foo'
      end
      subject.refresh!
    end

    it "should be modified" do
      subject.file_modified?(@the_file).should be_true
    end
  end
end
