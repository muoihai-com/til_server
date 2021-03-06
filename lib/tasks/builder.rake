namespace :builder do
  desc "Generate html file"
  task run: :environment do
    ItemBuilder.new.build_index
    ItemBuilder.new.build_show
    TagBuilder.new.build_show
  end

  desc "push to git"
  task publish: :environment do
    system "cd public; git pull origin master; git add .; git commit -m '#{Time.now.to_s}'; git push origin master;"
  end

  desc "generate and push"
  task production: :environment do
    Rake::Task['builder:precompile'].invoke
    Rake::Task['builder:run'].invoke
    Rake::Task['builder:sitemap'].invoke
    Rake::Task['builder:publish'].invoke
    system "git add .; git commit -m '#{Time.now.to_s}'; git push origin master;"
  end

  desc "Compile css, js"
  task precompile: :environment do
    FileUtils.rm_rf(Rails.root.join("public", "assets"))
    Rake::Task['assets:precompile'].invoke

    js_file_path = Dir.glob("public/assets/application-*.js").first
    puts ">> js: #{js_file_path}"
    FileUtils.mkdir_p(Rails.root.join("public", "javascripts"))
    FileUtils.mv(Rails.root.join(js_file_path), Rails.root.join("public", "javascripts", "application.js"))

    css_file_path = Dir.glob("public/assets/application-*.css").first
    puts ">> css: #{css_file_path}"
    FileUtils.mkdir_p(Rails.root.join("public", "stylesheets"))
    FileUtils.mv(Rails.root.join(css_file_path), Rails.root.join("public", "stylesheets", "application.css"))
    FileUtils.rm_rf(Rails.root.join("public", "assets"))
  end

  desc "sitemap"
  task sitemap: :environment do
    txt = BuilderFile.pluck(:output).map{|x| "https://muoihai.com/#{x}" }
    File.write(Rails.root.join("public", "sitemap.txt"), txt.join("\n"))
  end
end
