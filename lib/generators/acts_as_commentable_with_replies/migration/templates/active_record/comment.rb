class Comment < ::ActiveRecord::Base
  
  # settings
  acts_as_nested_set

  # relationships
  belongs_to :commentable, polymorphic: true, touch: true
  belongs_to :commenter, polymorphic: true, touch: true

  # validations
  validates_presence_of :commentable_id
  validates_presence_of :commenter_id
  validates_presence_of :message
  
end