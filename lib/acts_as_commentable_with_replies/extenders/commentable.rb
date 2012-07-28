module ActsAsCommentableWithReplies
  module Extenders

    module Commentable

      def commentable?
        false
      end

      def acts_as_commentable
        require 'acts_as_commentable_with_replies/commentable'
        include ActsAsCommentableWithReplies::Commentable

        class_eval do
          def self.commentable?
            true
          end
        end
      end

    end

  end
end