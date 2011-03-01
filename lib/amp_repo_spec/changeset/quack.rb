shared_examples_for 'changeset#quack' do |duck|
  [
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
  ].each do |meth|
    it {(duck || subject).should respond_to(meth)}
  end
end
