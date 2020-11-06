# Indago

Lightweight drop-in Ransack replacement without the ActiveRecord hackery.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'indago'
```

And then execute:

    $ bundle install

## Usage

In your controller:

```rb
require "indago"

class PostsController < ApplicationController
  SEARCH_FIELDS = [
    # Reusing scopes
    Indago::Field.new(:is_published) do |scope, value|
      value.present? ? scope.published : scope
    end,

    # Complex joins
    Indago::Field.new(:commented_by_id) do |scope, value|
      scope.where(
        id: Comment.where(author_id: value).select(:post_id).distinct
      )
    end,

    # Common search fields
    Indago::Field::Contain.new(:title_cont, :title),
    Indago::Field::Contain.new(:body_cont, :body),

    # Custom queries
    Indago::Field.new(:body_starts_with) do |scope, value|
      scope.where("body LIKE ?", "#{value}%")
    end
  ]

  def index
    @search = Indago::Search.new(Post.all, SEARCH_FIELDS, params[:q])
    @posts = @search.result
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nebulab/indago.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
