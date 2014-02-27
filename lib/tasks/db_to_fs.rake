require 'pathname'
require 'fileutils'
require 'yaml'

desc 'download collection from database to file system'
task :db_to_fs, [:path] => [:environment] do |t, args|
  raise 'Usage: bundle exec rake db_to_fs[:path]' unless args[:path]
  path = Pathname.new args[:path]

  FileUtils.rm_rf path if path.exist?
  FileUtils.mkdir path

  def download path, node, pos, total
    path += "#{pos.to_s.rjust(total.to_s.length, '0')}##{node.name}"
    FileUtils.mkdir path

    File.open(path + 'info.yml', 'w') do |file|
      hash = {
        'name' => node.name,
      }

      file.write hash.to_yaml
    end

    pages_total = node.pages.count
    node.pages.each_with_index do |page, page_pos|
      old_path = Pathname.new page.image.path(:original)
      new_path = path + "#{page_pos.to_s.rjust(pages_total.to_s.length, '0')}.jpg"
      FileUtils.cp old_path, new_path if old_path.exist?
    end

    children_total = node.children.count
    node.children.each_with_index do |child, child_pos|
      download path, child, child_pos, children_total
    end
  end

  download path, Node.root, 0, 0 if Node.root
end

