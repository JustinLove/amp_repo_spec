shared_examples_for 'local_repository#file_modified' do
  it {should respond_to :file_modified?}

  describe "in a new repo" do
    in_a_new_repo do
      add 'the.file'
    end
    subject {repo}

    it "is added, not modified" do
      subject.file_modified?('the.file').should be_false
    end
  end

  describe "after committing" do
    in_a_new_repo do
      add 'the.file'
      commit
    end
    subject {repo}

    it "should not be modified" do
      subject.file_modified?(@the_file).should be_false
    end
  end

  describe "after changes" do
    in_a_new_repo do
      add 'file.one'
      add 'file.two'
      commit
      modify 'file.one'
      modify 'file.two'
    end
    subject {repo}

    it "one file modified" do
      subject.file_modified?('file.one').should be_true
    end
    it "two files modified" do
      subject.file_modified?('file.two').should be_true
    end
  end
end
