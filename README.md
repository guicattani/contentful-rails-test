# README

This projects bears what I dearly nicknamed `ActiveContent(ful)` which is a in-memory `ActiveRecord` of sorts. It needs to load requests frequently from Contentful so I used a cache to improve performance (you can enable it in development by using `rails dev:cache`).

Code is not 100% optimized at the time being, but this is only due to time constraints.

No DB is necessary to run, since it's all coming from Contentful, just fill the credentials in `.env` file and run the server with `rails s`.

Tests can be ran with either `bundle exec guard` or `rspec`.

# Deploying

1. Fill credentials in `.env` file. A sample file is provided as `.env.sample`
2. Start a Redis service to run [coverband](https://github.com/danmayer/coverband)