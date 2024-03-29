class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :email_hash
      t.string :fb_id
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
