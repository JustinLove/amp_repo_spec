shared_examples_for 'staging_area#include' do
  it {should respond_to :include}

  describe 'include' do
    in_a_new_repo do
      add 'included.file'
      add 'normal.file'
      commit
      modify 'included.file'
      modify 'normal.file'
      repo.staging_area.include 'included.file'
    end
    subject {repo.staging_area}
    it {subject.file_status('included.file').should == :modified}
    it {subject.file_status('normal.file').should == :normal}
  end
end
