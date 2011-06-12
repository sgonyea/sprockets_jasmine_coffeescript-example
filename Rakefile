begin
  require 'bundler'
rescue => e
  puts 'Bundler could not be loaded. Please run `gem install bundler` from the command-line, and then `bundle install`.'
  raise e
end

Bundler.require :default

load 'jasmine/tasks/jasmine.rake'

namespace :compile do
  require 'sprockets'
  @env = Sprockets::Environment.new

  Tilt::CoffeeScriptTemplate.default_bare = true

  @compiler = proc {|resources_path, compiled_path, ext|
    @env.paths  << resources_path

    resources_pn = Pathname(resources_path)
    compiled_pn  = Pathname(compiled_path)
    resources    = Dir.glob(resources_pn.join("**/*.#{ext}*"))

    resources.each {|file|
      in_file   = Pathname(file).relative_path_from(resources_pn).to_s
      out_name  = in_file.gsub(/(.*)\.#{ext}\b.*$/, "\\1.#{ext}")
      out_file  = compiled_pn.join(out_name)

      out_file.dirname.mkpath unless Dir.exist?(out_file.dirname)

      File.open(out_file, 'w') do |out|
        out.write @env[in_file]
      end
    }
  }

  task :js do
    @compiler['resources/javascripts', 'compiled/javascripts', 'js']
  end

  task :css do
    @compiler['resources/stylesheets', 'compiled/stylesheets', 'css']
  end

  task :jasmine do
    @compiler['spec/javascripts', 'spec/compiled/javascripts', 'js']
  end
end

desc 'Compile all of your javascript and css assets, through Sprockets'
task :compile => ['compile:js', 'compile:css']

desc 'Compile all of your assets and run jasmine'
task :spec => ['compile', 'compile:jasmine', 'jasmine']
