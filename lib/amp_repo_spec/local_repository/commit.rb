shared_examples_for 'local_repository#commit' do
  it {should respond_to :commit}

  RSpec::Matchers.define :look_like_a_digest do
    match do |actual|
      actual && actual.to_s.match(/[0-9a-zA-Z]{20,40}/)
    end
  end

  describe "when in a brand new repo" do
    in_a_new_directory
    it "should not commit" do
      repo.init
      repo.commit(:message => 'test').should_not look_like_a_digest
    end
  end

  describe "when in a repo with one file" do
    in_a_new_repo do
      add 'some.file'
    end
    it "should commit" do
      repo.commit(:message => 'test').should look_like_a_digest
    end
  end

  describe "when in an existing repo" do
    in_a_new_repo do
      add 'some.file'
      commit
      add 'another.file'
    end
    it "should commit" do
      repo.commit(:message => 'test').should look_like_a_digest
    end
  end
  pending "after proving lower level operations"
end
