shared_examples_for 'staging_area#calculate_delta' do
  it {should respond_to :calculate_delta}
  describe 'calculate_delta' do
    in_a_new_repo do
      add 'unmodified.file'
      add 'modified.file'
      commit
      modify 'modified.file'
    end
    subject {repo.staging_area}
    it do
      stat = File.lstat('amp/unmodified.file')
      subject.calculate_delta('unmodified.file', stat).should == 0
    end
    it do
      stat = File.lstat('amp/modified.file')
      subject.calculate_delta('modified.file', stat).should be_kind_of(Fixnum)
    end
  end
end
