module ActsAsCommentableWithReplies
  module Commenter

    def self.included(base)
      base.class_eval do
        belongs_to :commenter, :polymorphic => true
        has_many :comments, :as => :commenter, :dependent => :delete_all do
          def commentables
            includes(:commentable).map(&:commentable)
          end
        end
      end
    end

    # voting
    def comment args = {}
      return nil if args[:commentable].nil? || args[:message].nil?
      args[:commentable].comment args.merge({:commenter => self})
    end


    def commented_on?(commentable)
      __comments__ = find_comments(:commentable_id => commentable.id, :commentable_type => commentable.class.name)
      __comments__.size > 0
    end

    def find_comments(extra_conditions = {})
      self.comments.where(extra_conditions)
    end

  end
end