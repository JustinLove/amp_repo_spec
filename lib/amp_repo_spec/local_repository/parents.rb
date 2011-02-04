shared_examples_for 'local_repository#parents' do
  it {should respond_to :parents}

  RSpec::Matchers.define :look_like_a_digest do
    match do |actual|
      actual && actual.to_s.match(/[0-9a-zA-Z]{20,40}/)
    end
  end

  describe "in a new repo" do
    in_a_new_repo
    subject {repo}

    its(:parents) {should be_kind_of(Array)}
    its(:parents) {should have(2).items}
    its(:parents) {subject.first.should be_nil}
    its(:parents) {subject.last.should be_nil}
  end

  describe "after committing" do
    in_a_new_repo do
      add 'some.file'
      commit
    end
    subject {repo}

    its(:parents) {subject.first.should look_like_a_digest}
    its(:parents) {subject.last.should be_nil}
  end

  pending "after proving merge"
end
