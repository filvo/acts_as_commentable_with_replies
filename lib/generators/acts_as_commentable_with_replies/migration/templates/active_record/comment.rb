class Comment < ::ActiveRecord::Base
  acts_as_nested_set

  attr_accessible :commentable_id, :commentable_type,
                  :commenter_id, :commenter_type,
                  :commentable, :commenter,
                  :message

  belongs_to :commentable, :polymorphic => true
  belongs_to :commenter, :polymorphic => true

  validates_presence_of :commentable_id
  validates_presence_of :commenter_id
  validates_presence_of :message
end