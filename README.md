# tests

## Adding your tests

Just add your unit test file to the `tests` directory.

Please replace 'LastName' with 'NetId' in your filename.

If using rspec, add `require 'rspec/autorun'` to your test file (see `tests/example_spec.rb`)

If using minitest, use `require 'minitest/autorun'` (see `tests/example_minitest.rb`)
Minitests users also **make sure your class has a unique name or it will not run** (such as `<NetId>Test`).

If using another (or no) testing framework, please make sure your file is runnable with `ruby filename` and then you can place it in the `tests` directory as normal.

If using no framework, it would be nice if you could format the output nicely, or quickly wrap your code in minitest or rspec.

Remove any importing of your Triple class or Enumerable module, we will use the standardized triple class in this directory.

## Setup

You need to run these commands to install the testing libraries. (You'll need admin privledges, `sudo` on Linux)

gem install rspec
gem install minitest

## Running

Specify the full path to your Enumerable module in `triple.rb`

Then simply:

    ruby run_all.rb