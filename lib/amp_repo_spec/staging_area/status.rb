shared_examples_for 'staging_area#status' do
  it {should respond_to :status}

  def show(x); true; end
  def hide(x); false; end

  describe 'in a new repository' do
    in_a_new_repo
    subject {repo.staging_area}

    it do
      subject.status(show(:ignored), show(:clean), show(:unknown)).should == {
        :modified => [],
        :added => [],
        :removed => [],
        :deleted => [],
        :unknown => ['Ampfile'],
        :ignored => [],
        :clean => [],
        :lookup => [],
        :delta => 0
      }
    end
  end

  describe 'in a modified repository' do
    in_a_new_repo do
      add 'unmodified.file'
      add 'modified.file'
      add 'removed.file'
      add 'deleted.file'
      commit
      add 'new.file'
      modify 'modified.file'
      remove 'removed.file'
      delete 'deleted.file'
      create 'mystery.file'
    end
    subject {repo.staging_area}

    pending do
      subject.status(show(:ignored), show(:clean), show(:unknown)).should == {
        :modified => [],
        :added => ['new.file'],
        :removed => ['removed.file'],
        :deleted => [],
        :unknown => ['Ampfile', 'mystery.file'],
        :ignored => [],
        :clean => ['deleted.file', 'modified.file', 'unmodified.file'],
        :lookup => [],
        :delta => 0
      }
    end
    pending do
      subject.status(show(:ignored), show(:clean), hide(:unknown)).should == {
        :modified => [],
        :added => ['new.file'],
        :removed => ['removed.file'],
        :deleted => [],
        :unknown => [],
        :ignored => [],
        :clean => ['deleted.file', 'modified.file', 'unmodified.file'],
        :lookup => [],
        :delta => 0
      }
    end
    pending do
      subject.status(show(:ignored), hide(:clean), show(:unknown)).should == {
        :modified => [],
        :added => ['new.file'],
        :removed => ['removed.file'],
        :deleted => [],
        :unknown => ['Ampfile', 'mystery.file'],
        :ignored => [],
        :clean => [],
        :lookup => [],
        :delta => 0
      }
    end
    pending('ignored')
  end

  pending 'depreciated?'
end
