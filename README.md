![Gem Version](https://img.shields.io/badge/finance_math-0.2-blue.svg)
[![Build Status](https://semaphoreapp.com/api/v1/projects/869d7630-55d3-46e5-9dc2-03d0d1cfecfe/363108/shields_badge.svg)](https://semaphoreapp.com/kolosek/finance_math)
[![Code Climate](https://codeclimate.com/github/kolosek/finance_math/badges/gpa.svg)](https://codeclimate.com/github/kolosek/finance_math)


## What is FinanceMath?

FinanceMath is a Ruby library for mapping Exel functions. Due to lack such libraries to handle every day need, this library is created.

## Installation

FinanceMath is available as a gem, to install it just install the gem:

    gem install finance_math

If you're using Bundler, add the gem to Gemfile.

    gem 'finance_math'

Run `bundle install`.

## Basic Usage

Create an instance, and pass parameters for nominal annual rate, duration (in months), and amount of loan.

```ruby

Loan.new(10.5, 12, 15000)
```

## Functions 

This is the list of available functions.

## PMT

Calculates the periodic payment for an annuity investment based on constant-amount periodic payments and a constant interest rate.

```ruby

loan = Loan.new(10.5, 12, 15000)
loan.pmt
```

## APR

Calculates the Annual Percentage Rate.

```ruby

loan = Loan.new(10.5, 12, 15000)

loan.apr
```

## Contributing

1. Fork it ( https://github.com/kolosek/finance_math/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Tests

Please cover with tests your pull requests

## License

MIT License. See LICENSE for details.

## Copyright

Copyright (c) 2014-2015 Nebojsa Zoric, and Kolosek, Inc. (http://kolosek.com)

For any Ruby on Rails related work, please contact directly via form on http://kolosek.com
