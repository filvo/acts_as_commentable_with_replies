require 'active_record'
require 'active_support/inflector'
require 'awesome_nested_set'

$LOAD_PATH.unshift(File.dirname(__FILE__))

module ActsAsCommentableWithReplies

  if defined?(ActiveRecord::Base)
    require 'acts_as_commentable_with_replies/extenders/commentable'
    require 'acts_as_commentable_with_replies/extenders/commenter'
    ActiveRecord::Base.extend ActsAsCommentableWithReplies::Extenders::Commentable
    ActiveRecord::Base.extend ActsAsCommentableWithReplies::Extenders::Commenter
  end

end