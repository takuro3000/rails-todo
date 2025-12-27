source "https://rubygems.org"

ruby "3.2.2"

# ============================================
# Core
# ============================================
gem "rails", "~> 7.1.6"
gem "puma", ">= 5.0"
gem "bootsnap", require: false

# ============================================
# Database
# ============================================
gem "pg", "~> 1.1"

# ============================================
# Frontend
# ============================================
gem "sprockets-rails"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"

# ============================================
# API / View
# ============================================
gem "jbuilder"

# ============================================
# Platform specific
# ============================================
gem "tzinfo-data", platforms: %i[windows jruby]

# ============================================
# Development & Test
# ============================================
group :development, :test do
  gem "debug", platforms: %i[mri windows]
  gem "rspec-rails", "~> 7.0"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
