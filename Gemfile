source 'https://rubygems.org'

if ENV.key?('PUPPET_VERSION')
  puppetversion = "#{ENV['PUPPET_VERSION']}"
else
  puppetversion = "~> 3.8.0"
end

gem 'rake'
gem 'puppet-lint'
# pin rspec to 3.1.0 until we can drop support for ruby 1.8.7
gem 'rspec', '~> 3.1.0'
gem "rspec-puppet"
gem 'puppet', puppetversion
gem 'puppetlabs_spec_helper'
