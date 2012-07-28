module ActsAsCommentableWithReplies
  module Commentable

    def self.included base
      base.class_eval do
        belongs_to :commentable, :polymorphic => true
        has_many   :comments, :as => :commentable do
          def commenters
            includes(:commenter).map(&:commenter)
          end
        end
      end
    end


    def default_conditions
      {
          :commentable_id => self.id,
          :commentable_type => self.class.base_class.name.to_s
      }
    end

    # voting
    def comment(args = {})
      return nil if args[:commenter].nil? || args[:message].nil?

      comment = Comment.new(
          :commentable => self,
          :commenter => args[:commenter],
          :message => args[:message]
      )

      if comment.save
        update_cached_comments
        comment.move_to_child_of(args[:parent]) if !args[:parent].nil?
        comment
      else
        nil
      end
    end
    alias :comment! :comment


    # caching
    def update_cached_comments
      updates = {}
      if self.respond_to?(:cached_comments_total=)
        updates[:cached_comments_total] = count_comments_total(true)
      end
      self.update_attributes(updates, :without_protection => true) if updates.size > 0
    end


    # counting
    def count_comments_total(skip_cache = false)
      if !skip_cache && self.respond_to?(:cached_comments_total)
        return self.send(:cached_comments_total)
      end
      find_comments.count
    end


    # results
    def find_comments(extra_conditions = {})
      comments.where(extra_conditions)
    end

    def root_comments
      find_comments :parent_id => nil
    end


    # commenters
    def commented_by?(commenter)
      comments = find_comments :commenter_id => commenter.id, :commenter_type => commenter.class.name
      comments.count > 0
    end



  end
end