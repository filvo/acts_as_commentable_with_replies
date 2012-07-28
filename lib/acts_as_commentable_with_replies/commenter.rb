module ActsAsCommentableWithReplies
  module Commenter

    def self.included(base)
      base.class_eval do
        belongs_to :commenter, :polymorphic => true
        has_many :comments, :as => :commenter do
          def commentables
            includes(:commentable).map(&:commentable)
          end
        end
      end
    end

    # voting
    def comment(args = {})
      return false if args[:commentable].nil? || args[:message].nil?
      args[:commentable].comment args.merge({:commenter => self})
    end

    # results
    def commented_on?(commentable)
      comments = find_comments(:commentable_id => commentable.id, :commentable_type => commentable.class.name)
      comments.size > 0
    end

    def find_comments(extra_conditions = {})
      comments.where(extra_conditions)
    end

    def find_comments_for_class(klass, extra_conditions = {})
      find_comments extra_conditions.merge({:commentable_type => klass.name})
    end

  end
end