class AmpRepoSpec::RepoFactory
  attr_reader :path
  attr_reader :repo
  def initialize(_path, _repo, &block)
    @path = _path
    @repo = _repo
    repo.init
    repo.add('changing.file')
    instance_eval(&block) if block_given?
    repo.refresh!
  end

  def create(name)
    modify(name)
  end

  def add(name)
    create(name)
    repo.add(name)
  end

  def modify(name)
    path.file('amp/'+name) {|f| f << Time.now.to_f.to_s}
  end

  def remove(name)
    repo.remove(name)
  end

  def delete(name)
    path = 'amp/'+name
    if File.directory?(path)
      Dir.delete(path)
    else
      File.delete(path)
    end
  end

  def commit
    repo.commit(:message => 'revised')
  end

  def revisions(n)
    n.times do
      modify('changing.file')
      commit
    end
  end
end
