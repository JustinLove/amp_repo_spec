shared_examples_for 'local_repository#each' do
  it {should respond_to :each}

  describe 'in a repository with two revisions' do
    in_a_new_directory do
      revisions 2
    end
    subject {repo}

    pending "should call the block multiple times" do
      counter = 0
      subject.each {counter += 1}
      counter.should == 2
    end
  end

  it {should be_kind_of(Enumerable)}
end
