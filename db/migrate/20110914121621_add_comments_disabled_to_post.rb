class AddCommentsDisabledToPost < ActiveRecord::Migration
  def change
    add_column :posts, :comments_disabled, :boolean
  end
end
