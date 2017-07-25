# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a
# newer version of cucumber-rails. Consider adding your own code to a new file
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.

require 'cucumber/rails'

# Capybara defaults to CSS3 selectors rather than XPath.
# If you'd prefer to use XPath, just uncomment this line and adjust any
# selectors in your step definitions to use the XPath syntax.
# Capybara.default_selector = :xpath

# By default, any exception happening in your Rails application will bubble up
# to Cucumber so that your scenario will fail. This is a different from how
# your application behaves in the production environment, where an error page will
# be rendered instead.
#
# Sometimes we want to override this default behaviour and allow Rails to rescue
# exceptions and display an error page (just like when the app is running in production).
# Typical scenarios where you want to do this is when you test your error pages.
# There are two ways to allow Rails to rescue exceptions:
#
# 1) Tag your scenario (or feature) with @allow-rescue
#
# 2) Set the value below to true. Beware that doing this globally is not
# recommended as it will mask a lot of errors for you!
#
ActionController::Base.allow_rescue = false

# Remove/comment out the lines below if your app doesn't have a database.
# For some databases (like MongoDB and CouchDB) you may need to use :truncation instead.
begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

# You may also want to configure DatabaseCleaner to use different strategies for certain features and scenarios.
# See the DatabaseCleaner documentation for details. Example:
#
#   Before('@no-txn,@selenium,@culerity,@celerity,@javascript') do
#     # { :except => [:widgets] } may not do what you expect here
#     # as Cucumber::Rails::Database.javascript_strategy overrides
#     # this setting.
#     DatabaseCleaner.strategy = :truncation
#   end
#
#   Before('~@no-txn', '~@selenium', '~@culerity', '~@celerity', '~@javascript') do
#     DatabaseCleaner.strategy = :transaction
#   end
#

# Possible values are :truncation and :transaction
# The :transaction strategy is faster, but might give you threading problems.
# See https://github.com/cucumber/cucumber-rails/blob/master/features/choose_javascript_database_strategy.feature
Cucumber::Rails::Database.javascript_strategy = :truncation

# The `.rspec` file also contains a few flags that are not defaults but that
# users commonly want.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
#
# Default Capabilites Options:
#   * Platform [platform]: MAC, WIN8, XP, WINDOWS, ANY, ANDROID (Default: ANY)
#   * Browser Name [browserName]: firefox, chrome, internet explorer, safari,
#                                 opera, iPad, iPhone, android (Default: chrome)
#
# BrowserStack Capabilities Options:
#   * Operating System [os]: WINDOWS, OS X
#   * OS Version [os_version]:
#       * Windows: XP, 7, 8 and 8.1
#       * OS X: Snow Leopard, Lion, Mountain Lion, Mavericks, Yosemite, El Capitan
#   * Browser [browser]: Firefox, Safari, IE, Chrome, Opera
#

require 'rspec/rails'
require 'capybara/rails'
require 'uri'
require 'capybara/rspec'
require 'rspec/retry'
require 'rspec/page-regression'

ENV['ENVIRONMENT'] ||= 'development'

virtual_box = ENV['VIRTUAL_BOX']
virtual_box_server_host = ENV['VIRTUAL_BOX_SERVER_HOST']
virtual_box_server_port = ENV['VIRTUAL_BOX_SERVER_PORT']
virtual_box_host = ENV['VIRTUAL_BOX_HOST']
virtual_box_port = ENV['VIRTUAL_BOX_PORT']

################## OS & Browser Settings ####################
bs_os = ENV['BS_OS'] || 'OS X'
bs_os_version = ENV['BS_OS_VERSION'] || 'El Capitan'
bs_browser = ENV['BS_BROWSER'] || 'Chrome'
bs_platform_name = "#{bs_os} #{bs_os_version}"

platform = ENV['BROWSER_PLATFORM'] || ENV['BS_OS'] || 'MAC'
browser_name = ENV['BROWSER_NAME'] || ENV['BS_BROWSER'] || 'chrome'
browser_version = ENV['BROWSER_VERSION'] ||  ENV['BS_BROWSER_VERSION']
resolution = '1920x1080'

app_host, server_host, server_port, project, retry_times = case ENV['ENVIRONMENT']
                                              when 'staging'
                                                if virtual_box
                                                  ["http://#{virtual_box_server_host}:#{virtual_box_server_port}", virtual_box_server_host, virtual_box_server_port, 'mokapos-staging', 3]
                                                else
                                                  ['https://staging.mokapos.com', 'staging.mokapos.com', '80', 'mokapos-staging', 3]
                                                end
                                              when 'develop-stage'
                                                ['http://backoffice-dev.mokapos.com', 'backoffice-dev.mokapos.com', '80', nil, 1]
                                              else
                                                ['https://www.mokapos.com', 'www.mokapos.com', '80', nil, 1]
                                              end

Capybara.app_host = app_host
Capybara.server_host = server_host
Capybara.server_port = server_port
Capybara.run_server = false
Capybara.default_max_wait_time = 120

module Capybara
  class << self
    attr_accessor :session_id, :remote_automation_platform
  end
end

Before '@javascript' do |scenario|
  $scenario_name = scenario.feature.name
  page.driver.browser.manage.window.resize_to(1366, 768)
end

Capybara.register_driver :selenium do |app|
  remote = ['staging', 'develop-stage'].include?(ENV['ENVIRONMENT'])
  file_name = $scenario_name
  time = Time.now.strftime("%Y%m%d")

  selenium_version = nil #Gem.loaded_specs["selenium-webdriver"].version.to_s
  ################## REMOTE CONNECTION ####################
  remote_username = ENV['BS_USERNAME'] || ENV['SAUCE_USERNAME']
  remote_access_key = ENV['BS_AUTHKEY'] || ENV['SAUCE_ACCESS_KEY']
  remote_url = ENV['SELENIUM_HOST']

  url = virtual_box ? "http://#{virtual_box_host}:#{virtual_box_port}/wd/hub" : "http://#{remote_username}:#{remote_access_key}@#{remote_url}/wd/hub"

  ################## Automation Capabilities Metadata ####################
  build = "Travis-CI-#{ENV['TRAVIS_BUILD_NUMBER']}" if ENV['TRAVIS_BUILD_NUMBER']
  build ||= "#{ENV['BUILD']}-#{time}" if ENV['BUILD']
  build ||= "Build-#{time}"
  platform_name = bs_platform_name
  full_browser_name = browser_name
  full_browser_name += " version #{browser_version}" unless browser_version.blank?
  name = "Job #{ENV['TRAVIS_JOB_NUMBER']} (#{file_name})"
  name += " [#{ENV['ENVIRONMENT']}]" unless ENV['ENVIRONMENT'].blank?
  name += ": #{platform_name} > #{full_browser_name}"

  tags = [ENV['ENVIRONMENT'], project, server_host, platform, bs_os, bs_os_version, browser_name, full_browser_name, ENV['TRAVIS_JOB_NUMBER'], file_name].compact

  custom_data = {}
  release = ENV['TRAVIS_BRANCH'] || ENV['BRANCH']
  custom_data[:release] = release if release
  custom_data[:commit] = ENV['TRAVIS_COMMIT'] if ENV['TRAVIS_COMMIT']
  custom_data[:staging] = ENV['ENVIRONMENT'] == 'staging'
  custom_data[:commit] = ENV['TRAVIS_JOB_NUMBER'] if ENV['TRAVIS_JOB_NUMBER']
  custom_data[:server] = server_host

  caps = {
    # platform: platform,
    browserName: bs_browser.downcase, # Because selenium hub need browserName parameter
    # version: browser_version,
    build: build,
    name: name,
    tags: tags,
    passed: true,
    customData: custom_data,
    # Browserstack Capabilities
    project: project,
    os: bs_os,
    os_version: bs_os_version,
    browser: bs_browser,
    browser_version: browser_version,
    resolution: resolution,
    'browserstack.local' => (ENV['ENVIRONMENT'] == 'development').to_s,
    'browserstack.debug' => 'true',
    'browserstack.timezone' => 'Jakarta',
    nativeEvents: false,
    requireWindowFocus: true
  }

  caps[:seleniumVersion] = selenium_version if selenium_version

  @driver = if remote
              Capybara::Selenium::Driver.new(app, browser: :remote, url: url, desired_capabilities: caps)
            else
              case bs_browser
                when 'Firefox'
                  profile = Selenium::WebDriver::Firefox::Profile.new

                  capabilities = Selenium::WebDriver::Remote::Capabilities.firefox(:firefox_profile => profile)
                  Capybara::Selenium::Driver.new app, browser: bs_browser.downcase.to_sym, desired_capabilities: capabilities
                when 'Chrome'
                  prefs = {
                  }

                  Capybara::Selenium::Driver.new app, detach: false, browser: bs_browser.downcase.to_sym, prefs: prefs
                else
                  Capybara::Selenium::Driver.new app, browser: bs_browser.downcase.to_sym
              end
            end

  Capybara.session_id = @driver.browser.session_id if remote

  @driver
end
