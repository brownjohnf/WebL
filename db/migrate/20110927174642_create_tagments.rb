class CreateTagments < ActiveRecord::Migration
  def change
    create_table :tagments do |t|
      t.integer :post_id
      t.integer :tag_id
      t.timestamps
    end
		add_index :tagments, [:post_id, :tag_id], :unique => true
  end
end
