class CreateForums < ActiveRecord::Migration
  def self.up
    create_table :forums do |t|
      t.string :name
      t.integer :previous
      t.integer :parent

      t.timestamps
    end
  end

  def self.down
    drop_table :forums
  end
end
