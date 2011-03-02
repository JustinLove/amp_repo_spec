AmpRepoSpec::ChangesetMethods = [
    :changed_files,
    :changed_lines_statistics,
    :include?,
    :useful_parents,
    :to_templated_s,
    :template_for_options,
    :walk,
    :parents,
    :each,
    :<=>,
    :get_file,
    :date,
    :user,
    :branch,
    :description,
    :altered_files,
    :all_files,
    :working?,
]
shared_examples_for 'changeset#quack' do |duck|
  AmpRepoSpec::ChangesetMethods.each do |meth|
    it {(duck || subject).should respond_to(meth)}
  end
end
RSpec::Matchers.define :quack_like_a_changeset do
  match do |actual|
    (AmpRepoSpec::ChangesetMethods - actual.methods).empty?
  end

  failure_message_for_should do |actual|
    "expected #{actual.class} to respond to #{AmpRepoSpec::ChangesetMethods - actual.methods}"
  end
end

