AmpRepoSpec::AChangeset = [
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
class <<AmpRepoSpec::AChangeset
  def inspect
    'a changeset'
  end
end

shared_examples_for "changeset#quack" do
  it {should quack_like AmpRepoSpec::AChangeset}
end
