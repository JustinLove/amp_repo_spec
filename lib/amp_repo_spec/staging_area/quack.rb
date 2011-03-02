AmpRepoSpec::AStagingArea = [
  :tracking?,
  :examine_named_files,
  :find_with_patterns,
  :walk,
  :status,
  :add,
  :remove,
  :normal,
  :forget,
  :copy,
  :move,
  :include,
  :exclude,
  :file_status,
  :vcs_dir,
  :save,
  :all_files,
  :ignoring_directory?,
  :ignoring_file?,
  :file_precise_status,
  :calculate_delta,
]
class <<AmpRepoSpec::AStagingArea
  def inspect
    'a staging area'
  end
end

shared_examples_for "staging_area#quack" do
  it {should quack_like AmpRepoSpec::AStagingArea}
end
