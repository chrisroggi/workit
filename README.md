# Workit

The workout tracking API

## Getting Started

These instructions will get you up and running on Mac OS.

### Prerequisites

Install Ruby 2.3.3

<https://www.ruby-lang.org/en/documentation/installation>

Install Rails 5.0.7
```
gem install rails -v 5.0.7
```

Install PostgreSQL
```
brew install postgresql
```

### Setup

Initialize the database
```
rails db:setup
```

### Run

Start the rails server
```
rails s
```

Endpoints will now be accessible via `http://localhost:3000`