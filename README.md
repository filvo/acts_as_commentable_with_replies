# Acts As Commentable With Replies

## Please don't use it as of now. Because it's under testing.

Acts As Commentable With Replies is a Ruby Gem specifically written for Rails/ActiveRecord models.
The main goals of this gem are:

- Allow any model to be commentable.
- Allow any model to post comment.  In other words, comments do not have to come from a user,
  they can come from any model (such as a Group or Team).
- Provide an easy to write/read syntax.

## Installation

Add this line to your application's Gemfile:

    gem 'acts_as_commentable_with_replies'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install acts_as_commentable_with_replies


### Database Migrations & Model Generator

Acts As Commentable With Replies uses a comments table to store all comments.  To
generate migration, model just use.

    rails generate acts_as_commentable_with_replies:migration
    rake db:migrate

You will get a performance increase by adding in cached columns to your model's
tables.  You will have to do this manually through your own migrations.  See the
caching section of this document for more information.

## Usage

### Commentable Models

    class Post < ActiveRecord::Base
      acts_as_commentable
    end

    @post = Post.new(:title => 'my post!')
    @post.save

    @post.comment(:commenter => @user, :message => 'hello this is my comment!')
    @post.comments.size # =>  1

You can also use it as a reply system in comments

    @comment = Comment.find(1)
    @post.comment(:commenter => @user, :message => 'nice!', :parent => @comment)


### Commenter Models

    class User < ActiveRecord::Base
      acts_as_commenter
    end

    @post = Post.find(1)
    @user = User.find(1)
    @user.comment(:commentable => @post, :message => 'Comment posted through Commenter')


### Some Useful syntaxes

    # to check whether or not user has posted comment on it
    @post.commented_by?(@user)

    #or
    @user.commented_on?(@post)

    # to get the list of root comments, not replies
    @post.root_comments


### Caching

To speed up performance you can add cache columns to your commentable model's table.  These
columns will automatically be updated after each comment.  For example, if we wanted
to speed up @post we would use the following migration:

    class AddCachedCommentsToPosts < ActiveRecord::Migration
      def self.up
        add_column :posts, :cached_comments_total, :integer, :default => 0
        add_index  :posts, :cached_comments_total
      end

      def self.down
        remove_column :posts, :cached_comments_total
      end
    end


## TODO

Don't know. Haven't decided yet.


## Credits
* [Ryan T](https://github.com/ryanto) - This gem is heavily influenced from [acts_as_voteable]
* [Evan David Light](https://github.com/elight) - Because this gem is inspired from [acts_as_commentable_with_threading].
But [acts_as_commentable_with_threading] only supports user as commenter and there are no shortcuts to create comment.

Thank you guys! Without you I don't know if it was possible or not!


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
