class ActsAsCommentableWithRepliesMigration < ActiveRecord::Migration

  def self.up
    create_table :comments do |t|
      t.references :commentable, :polymorphic => true
      t.references :commenter, :polymorphic => true

      t.text :message
      t.integer :parent_id, :lft, :rgt

      t.timestamps
    end

    add_index :comments, [:commentable_id, :commentable_type]
    add_index :comments, [:commenter_id, :commenter_type]
  end

end