require 'active_record'
require 'active_support/inflector'
#require 'acts_as_commentable_with_replies/version'

$LOAD_PATH.unshift(File.dirname(__FILE__))

module ActsAsCommentableWithReplies

  if defined?(ActiveRecord::Base)
    require 'acts_as_commentable_with_replies/extenders/commentable'
    require 'acts_as_commentable_with_replies/extenders/commenter'
    #require 'acts_as_commentable_with_replies/comment'
    ActiveRecord::Base.extend ActsAsCommentableWithReplies::Extenders::Commentable
    ActiveRecord::Base.extend ActsAsCommentableWithReplies::Extenders::Commenter
  end

end