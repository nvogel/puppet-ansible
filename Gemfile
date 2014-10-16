source "http://rubygems.org"

# see https://github.com/rodjek/rspec-puppet/issues/200
rspecversion = ENV.key?('RSPEC_VERSION') ? "= #{ENV['RSPEC_VERSION']}" : ['>= 2.9 ', '< 3.0.0']

group :test do
  gem "rake", '~> 10.3'
  gem 'rspec', rspecversion
  gem "puppet", ENV['PUPPET_VERSION'] || '~> 3.7.0'
  gem "puppet-lint", '~> 1.0.0'
  gem "rspec-puppet", '~> 1.0.0'
  gem "puppet-syntax", '~> 1.3.0'
  gem "puppetlabs_spec_helper", '~> 0.8.0'
end

group :development do
  if RUBY_VERSION !~ /^1.8/
    gem "guard-rake"
  end
end
