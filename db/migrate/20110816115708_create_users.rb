class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :cookie_hash
      t.integer :roles_mask

      t.timestamps
    end
  end
end
