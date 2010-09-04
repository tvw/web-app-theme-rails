require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "web-app-theme-rails"
    gem.summary = %Q{web-app-theme rails3 generator}
    gem.description = %Q{A template generator for Rails 3 providing the nice templates from WebAppTheme with support for ERB and Haml}
    gem.email = "tvw@s4r.de"
    gem.homepage = "http://github.com/tvw/web-app-theme-rails"
    gem.authors = ["Thomas Volkmar Worm"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.files = FileList["lib/**/*"]
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

# require 'spec/rake/spectask'
# Spec::Rake::SpecTask.new(:spec) do |spec|
#   spec.libs << 'lib' << 'spec'
#   spec.spec_files = FileList['spec/**/*_spec.rb']
# end

# Spec::Rake::SpecTask.new(:rcov) do |spec|
#   spec.libs << 'lib' << 'spec'
#   spec.pattern = 'spec/**/*_spec.rb'
#   spec.rcov = true
# end

# task :spec => :check_dependencies

# task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "web-app-theme-rails #{version}"
  rdoc.rdoc_files.include('README*', 'LICENSE', 'HISTORY')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc "Cleanup the project"
task :clean => ["testapp:clobber", :clobber_rdoc] do
  rm_rf "pkg" if File.exist?('pkg')
end


################################################################################
## Testapp
################################################################################
desc "Generate a rails test app"
task :testapp => "testapp:default"

namespace :testapp do
  desc "Generates and installs the gem"
  task :gem => :build do
    version = File.exist?('VERSION') ? File.read('VERSION').gsub(/\s*/,'') : ""
    sh "gem install pkg/web-app-theme-rails-#{version}.gem --no-ri"
  end

  task :railsapp do
    sh "rails new testapp --database sqlite3"
    cp 'application.rb', 'testapp/config'
  end

  task :gemfile do
    # Gemfile
    Dir.chdir("testapp") do
      File.open("Gemfile","w") do |fh|
        fh.puts "source 'http://rubygems.org'"
        fh.puts "gem 'rails', '3.0.0.rc'"
        fh.puts "gem 'sqlite3-ruby', :require => 'sqlite3'"
        fh.puts "group :development do"
        fh.puts "  gem 'web-app-theme-rails'"
        fh.puts "end"
      end
    end
  end

  task :gemfile_haml do
    # Gemfile
    Dir.chdir("testapp") do
      File.open("Gemfile","w") do |fh|
        fh.puts "source 'http://rubygems.org'"
        fh.puts "gem 'rails', '3.0.0.rc'"
        fh.puts "gem 'sqlite3-ruby', :require => 'sqlite3'"
        fh.puts "gem 'haml'"
        fh.puts "group :development do"
        fh.puts "  gem 'web-app-theme-rails'"
        fh.puts "end"
      end
    end
  end

  task :scaffold do
    Dir.chdir("testapp") do
      sh "rails generate scaffold --help"
      sh "rails generate web_app_theme:layout"
      sh "rails generate scaffold Address name:string town:string"
      sh "rake db:migrate"
      sh "rails server"
    end
  end

  task :server do
    Dir.chdir("testapp") do
      sh "rails server"
    end
  end

  task :default => [:clobber, :gem, :railsapp, :gemfile, :scaffold, :server]
  task :haml    => [:clobber, :gem, :railsapp, :gemfile_haml, :scaffold, :server]

  desc "Removes the rails test app"
  task :clobber do
    rm_rf "testapp" if File.exist?('testapp')
  end
end
