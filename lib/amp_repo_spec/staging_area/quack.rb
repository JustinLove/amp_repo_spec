shared_examples_for 'a staging area duck' do |duck|
  [
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
  ].each do |meth|
    it {duck.should respond_to(meth)}
  end
end
