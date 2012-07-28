module ActsAsCommentableWithReplies
  module Extenders

    module Commenter

      def commenter?
        false
      end

      def acts_as_commenter(*args)
        require 'acts_as_commentable_with_replies/commenter'
        include ActsAsCommentableWithReplies::Commenter

        class_eval do
          def self.commenter?
            true
          end
        end

      end

    end
  end
end