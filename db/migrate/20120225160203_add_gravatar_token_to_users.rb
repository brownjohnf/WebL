class AddGravatarTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gravatar_token, :string

  end
end
