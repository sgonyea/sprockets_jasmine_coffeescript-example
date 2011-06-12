require 'rubygems'
require 'bundler/setup'
require 'jasmine'

require Bundler.root.join('spec/javascripts/support/jasmine_config')

jasmine_config  = Jasmine::Config.new
spec_builder    = Jasmine::SpecBuilder.new(jasmine_config)
should_stop     = false

if Jasmine::rspec2?
  RSpec.configuration.after(:suite) do
    spec_builder.stop if should_stop
  end
else
  Spec::Runner.configure do |config|
    config.after(:suite) do
      spec_builder.stop if should_stop
    end
  end
end

spec_builder.start
should_stop = true
spec_builder.declare_suites
