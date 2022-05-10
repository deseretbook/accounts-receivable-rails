# Accounts Receivable

Welcome to the Accounts Receivable system! This system is responsible for
creating, sending, and tracking invoices sent to clients so we can be paid for
our products and services.

## Getting started

### Prerequisites

Before you get started, be sure to:

* Be running Ruby 3.x
* That you have a recent version of Bundler installed (e.g. `gem install
  bundler`)
* That you have a recent version of git installed (e.g. `brew install git` on a
  Mac)

### Initial setup

This is a conventional Ruby on Rails app, so you should be able to get up and
running with the following commands:

```
$ bundle install
$ bin/rails db:setup
```

(Note that in addition to running migrations, we're also loading the app's
seed data into the development database to help move things along.)

If nothing blew up, you should be able to start the Rails server:

```
$ bin/rails server
```

And then you should be able to see pre-generated invoices in a browser:
[http://localhost:3000/invoices](http://localhost:3000/invoices)



