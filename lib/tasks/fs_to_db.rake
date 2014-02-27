require 'pathname'
require 'fileutils'
require 'yaml'

desc 'upload collection from file system to database'
task :fs_to_db, [:path] => [:environment] do |t, args|
  raise 'Usage: bundle exec rake fs_to_db[:path]' unless args[:path]
  path = Pathname.new args[:path]

  def upload path, parent
    params = YAML.load_file(path + 'info.yml')

    node = Node.new params
      .merge(parent: parent)
      .except('name')

    %w{ name }.each do |property|
      node.update_attributes property => params[property]
    end

    path.children.sort.each do |p|
      unless p.directory? or p.basename.to_s == 'info.yml'
        Page.create node: node, image: File.open(p)
      end
    end

    path.children.sort.each do |p|
      if p.directory?
        upload p, node
      end
    end
  end

  upload path.children.select { |c| c.directory? }.first, nil
end

