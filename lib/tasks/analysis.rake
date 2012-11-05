namespace :analyzer do
    desc "run rails_best_practices"
    task :rails_best_practices do
      require 'rails_best_practices'
      app_root = Rake.application.original_dir
      output_file = File.join(app_root, 'analyzer', 'rails_best_practices.html')
      analyzer = RailsBestPractices::Analyzer.new(app_root, {
        'format' => 'html',
        'with-textmate' => true,
        'output-file' => output_file
      })
      analyzer.analyze
      analyzer.output
      fail "found bad practices, see details in " + output_file if analyzer.runner.errors.size >0
    end

    desc "run flay and analyze code for structural similarities"
    task :flay do
      output = `flay #{FileList["lib/**/*.rb", "app/**/*.rb"].join(' ')}`
      fail "Error #{$?}: #{output}" unless $? == 0
      puts output    
  end
end
