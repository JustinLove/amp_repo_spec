shared_examples_for 'local_repository#commit' do
  it {should respond_to :commit}

  RSpec::Matchers.define :look_like_a_digest do
    match do |actual|
      actual && actual.to_s.match(/[0-9a-zA-Z]{20,40}/)
    end
  end

  def repo_in(path)
    self.class.subject {described_class.new(path.to_s)}
    subject.init
  end

  def in_a_new_repo
    within_construct do |path|
      repo_in(path)
      yield(path)
    end
  end


  it "should not commit in a brand new repo" do
    in_a_new_repo do
      subject.commit(:message => 'test').should_not look_like_a_digest
    end
  end

  it "should commmit in a repo with one file" do
    in_a_new_repo do |path|
      path.file('some.file')
      subject.add('some.file')
      subject.commit(:message => 'test').should look_like_a_digest
    end
  end

  pending "after proving lower level operations"
end
