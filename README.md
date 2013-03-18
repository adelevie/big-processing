# big-processing

## What?

This library allows you to split up work by sending big processing tasks to IronWorker instances.

## Why?

I'm using it to process the thousands of government documents stored on [Dokket.com](http://dokket.com). This library adds a small layer of abstraction over IronWorker, allowing you to focus on writing simple Ruby code.

`big-processing` means you don't have to worry about:

1. Amazon EC2
2. Threads
3. Complicated computer science things

The goal of this library is provide an API that feels as much like plain Ruby code as possible, while unleashing the power of tens, hundreds, or thousands of cloud-based compute instances.

## Usage

```ruby
require 'big-processing'

BigProcessing::Configuration do |c|
  c.ironio_project_id = "abcdefgh"
  c.ironio_token      = "12345678"
  c.aws_id            = "ijklmnop"
  c.aws_token         = "910111213"
  c.aws_bucket        = "my_cool_project"
end

big_processing_array = BigProcessing::Array.new
document_urls = Document.all.map {|d| d.url}   # ActiveRecord example. This could be anything, all you need is an Array.

document_urls.each_slice(50) do |urls|
  op = BigProcessing::Operation.new
  op.worker_name = "extract_tags"
  op.input = {"urls" => urls}
  big_processing_array << op.begin_immediately!
end

results = big_processing_array.process! # blocks until all `Operation`s have finished.
```

## Installation

TODO

### Writing Workers

TODO

## Contributing to big-processing
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2013 Alan deLevie. See LICENSE.txt for
further details.

