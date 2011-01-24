shared_examples_for 'local_repository#each' do
  it {should respond_to :each}

  Amp::Hook = Object.new
  class << Amp::Hook
    def run_hook(*args)
    end
  end

  Amp::Match = Class.new
  class Amp::Match
    def self.create(*args); new; end
    def call(*args); true; end
    def files; []; end
  end

  in_a_new_directory
  subject {repo}

  describe 'in a repository with two revisions' do
    before(:all) do
      subject.init
      File.open('test.txt', 'w') do |f|
        f.write('something')
      end
      subject.add('test.txt')
      subject.commit(:message => 'one')

      File.open('test.txt', 'a') do |f|
        f.write('else')
      end
      subject.add('test.txt')
      subject.commit(:message => 'two')
    end

    pending "should call the block multiple times" do
      counter = 0
      subject.each {counter += 1}
      counter.should == 2
    end
  end

  it {should be_kind_of(Enumerable)}
end
