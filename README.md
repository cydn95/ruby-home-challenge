# Code challenge

## Confirm emailed & non-emailed users which belong to a correct company

## Problem

Any user that belongs to a company in the companies file and is active
needs to get a token top up of the specified amount in the companies top up field.

## Task

You have a json file of users.
You have a json file of companies.

Please look at these files.
Create code in Ruby that process these files and creates an
output.txt file.

If the users company email status is true indicate in the output that the
user was sent an email ( don't actually send any emails).
However, if the user has an email status of false, don't send the email
regardless of the company's email status.

Companies should be ordered by company id.
Users should be ordered alphabetically by last name.

### Important points

- There could be bad data
- The code should be runnable in a command line
- Code needs to be written in Ruby
- Code needs to be cloneable from github
- Code file should be named challenge.rb

## Installation

Install the required ruby gems

    $ bundle install

## Tests

Run the tests

    $ bundle exec rake test

## Run

Show a result on console

    $ bundle exec rake challenge:console

Generate an output.txt

    $ bundle exec rake challenge:txt
