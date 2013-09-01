require './test/lib/qunit.rb'

task :default => [:dependencies, :qunit, :commit, :publish]

task :dependencies do
	sh 'bundle install'
end

task :commit do
	puts "Committing and Pushing to Git"
	require 'git_repository'
	commit_message = ENV["m"] || 'no commit message'
	git = GitRepository.new
	git.add
	git.commit(:message => "#{commit_message}")
	git.push
end

task :publish do
	puts "Deploying to heroku"
	require 'git_repository'
	git = GitRepository.new(:remote => "heroku")
	git.push
end

qunit :qunit do |config|
	config.phantom_exe = './test/lib/phantomjs'
	config.qunit_runner = './test/lib/run-qunit.js'
	config.test_directory = './test'
end

