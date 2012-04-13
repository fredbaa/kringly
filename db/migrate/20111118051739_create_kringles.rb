class CreateKringles < ActiveRecord::Migration
  def self.up
    create_table :kringles do |t|
      t.integer :user_id
      t.integer :manito_id
      t.timestamps
    end

    add_index :kringles, :user_id
    add_index :kringles, :manito_id
  end

  def self.down
    drop_table :kringles
  end
end
