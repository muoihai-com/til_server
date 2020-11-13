namespace :builder do
  desc "Generate html file"
  task run: :environment do
    ItemBuilder.new.build_index
    ItemBuilder.new.build_show

    system "cd public; git add .; git commit -m '#{Time.now.to_s}'; git push origin master;"
  end

  desc "Compile css, js"
  task precompile: :environment do
    FileUtils.rm_rf(Rails.root.join("public", "assets"))
    Rake::Task['assets:precompile'].invoke

    js_file_path = Dir.glob("public/assets/*.js").first
    FileUtils.mkdir_p(Rails.root.join("public", "javascripts"))
    FileUtils.mv(Rails.root.join(js_file_path), Rails.root.join("public", "javascripts", "application.js"))

    css_file_path = Dir.glob("public/assets/*.css").first
    FileUtils.mkdir_p(Rails.root.join("public", "stylesheets"))
    FileUtils.mv(Rails.root.join(css_file_path), Rails.root.join("public", "stylesheets", "application.css"))
    FileUtils.rm_rf(Rails.root.join("public", "assets"))
  end
end
