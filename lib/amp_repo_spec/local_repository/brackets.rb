require 'amp_repo_spec/changeset/quack'

shared_examples_for 'local_repository#brackets' do
  it {should respond_to :[]}

  shared_examples_for 'changeset reference' do
    describe "'tip'" do
      subject {repo['tip']}
      it_should_behave_like "changeset#quack"
      its(:working?) {should be_false}
    end

    describe ":tip" do
      subject {repo[:tip]}
      it_should_behave_like "changeset#quack"
      its(:working?) {should be_false}
    end

    describe "'.'" do
      subject {repo['.']}
      it_should_behave_like "changeset#quack"
      its(:working?) {should be_false}
    end

    describe "nil" do
      subject {repo[nil]}
      it_should_behave_like "changeset#quack"
      its(:working?) {should be_true}
    end
  end
  
  describe "in a new repo" do
    in_a_new_repo
    it_should_behave_like 'changeset reference'
  end

  describe "after committing" do
    in_a_new_repo do
      add 'some.file'
      commit
    end
    it_should_behave_like 'changeset reference'
  end

  pending 'Integer, String'
end
