class ChangeCommentsCommentTextType < ActiveRecord::Migration
  def change
    change_column :comments, :comment_text, :text
  end
end
