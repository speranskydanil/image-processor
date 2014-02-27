require 'pathname'

desc 'add test data'
task :atd, [:path] => [:environment] do |t, args|
  raise 'Usage: bundle exec rake atd[:path]' unless args[:path]
  path = Pathname.new args[:path]

  def description
    Array.new(rand(256..1024)).map { 'abcdefghigklmnopqrstuvwxyz       '.split('').sample }.join('').strip
  end

  def project_name(i)
    "Project #{i.to_s.rjust(2, '0')}"
  end

  def publication_name(i, j)
    "Publication #{i.to_s.rjust(2, '0')} #{j.to_s.rjust(2, '0')}"
  end

  5.times do |i|
    project = Node.create name: project_name(i),
                          parent: Node.root,
                          status: NodeStatus.all.sample,
                          description: description

    10.times do |j|
      publication = Node.create name: publication_name(i, j),
                                parent: project,
                                status: NodeStatus.all.sample,
                                description: description

      rand(5..10).times do
        Page.create node: publication, image: File.open(path.children.sample)
      end
    end
  end
end

