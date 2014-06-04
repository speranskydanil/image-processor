namespace :assets do
  desc 'Create nondigest assets'
  task :create_nondigest_assets do
    fingerprint = /\-[0-9a-f]{32}\./

    for file in Dir['public/assets/jQuery-File-Upload/img/*']
      next unless file =~ fingerprint
      nondigest = file.sub fingerprint, '.'
      FileUtils.cp file, nondigest, verbose: true
    end
  end
end

Rake::Task['assets:precompile'].enhance do
  Rake::Task['assets:create_nondigest_assets'].invoke
end

