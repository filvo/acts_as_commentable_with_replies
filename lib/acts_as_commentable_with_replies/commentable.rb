module ActsAsCommentableWithReplies
  module Commentable

    def self.included base
      base.class_eval do
        belongs_to :commentable, :polymorphic => true
        has_many   :comments, :as => :commentable, :dependent => :delete_all do
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
    def comment args = {}
      return nil if args[:commenter].nil? || args[:message].nil?

      __comment__ = Comment.new(
          :commentable => self,
          :commenter => args[:commenter],
          :message => args[:message]
      )

      if __comment__.save
        update_comments_counter
        __comment__.move_to_child_of(args[:parent]) if !args[:parent].nil?
        __comment__
      else
        nil
      end
    end

    def commented_by? commenter
      __comments__ = find_comments :commenter_id => commenter.id, :commenter_type => commenter.class.name
      __comments__.count > 0
    end


    # caching
    def update_comments_counter
      if self.respond_to?(:cached_comments_total=)
        self.class.where(:id => self.id).update_all(:cached_comments_total => self.comments.count)
      end
    end


    # results
    def find_comments extra_conditions = {}
      self.comments.where(extra_conditions)
    end

    def root_comments
      find_comments :parent_id => nil
    end


  end
end