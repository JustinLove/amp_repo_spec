require 'amp_repo_spec/changeset/quack'

shared_examples_for 'local_repository#brackets' do
  it {should respond_to :[]}

  shared_examples_for 'changeset reference' do
    describe "'tip'" do
      subject {repo['tip']}
      it {should quack_like_a_changeset}
      its(:working?) {should be_false}
    end

    describe ":tip" do
      subject {repo[:tip]}
      it {should quack_like_a_changeset}
      its(:working?) {should be_false}
    end

    describe "'.'" do
      subject {repo['.']}
      it {should quack_like_a_changeset}
      its(:working?) {should be_false}
    end

    describe "nil" do
      subject {repo[nil]}
      it {should quack_like_a_changeset}
      its(:working?) {should be_true}
    end
  end
  
  describe "in a new repo" do
    in_a_new_repo
    it_should_behave_like 'changeset reference'
  end

  describe "after committing" do
    $node = ''
    in_a_new_repo do
      add 'some.file'
      $node = commit
    end
    it_should_behave_like 'changeset reference'

    describe "Integer" do
      subject{repo[0]}
      it {should quack_like_a_changeset}
      its(:working?) {should be_false}
    end

    describe "String" do
      subject{repo[$node.to_s]}
      it {should quack_like_a_changeset}
      its(:working?) {should be_false}
    end

    describe "Node" do
      subject{repo[$node]}
      it {should quack_like_a_changeset}
      its(:working?) {should be_false}
    end
  end
end
