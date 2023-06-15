#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle update rake
bundle exec rake db:migrate