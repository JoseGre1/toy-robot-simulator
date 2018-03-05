namespace :toyRobotSimulator do
  task test: %w[code_quality tests]

  desc "Runs rubocop"
  task :code_quality do
    puts "----Rubocop----"
    sh "bundle exec rubocop"
  end

  desc "Run Rspec tests"
  task :tests do
    puts "----Rspec----"
    sh "bundle exec rspec"
  end
end
