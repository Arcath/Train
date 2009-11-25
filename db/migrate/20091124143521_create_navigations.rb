class CreateNavigations < ActiveRecord::Migration
  def self.up
    create_table :navigations do |t|
      t.string :text
      t.integer :parent
      t.string :destination_controller
      t.string :destination_action
      t.string :destination_id
      t.string :permalink

      t.timestamps
    end
  end

  def self.down
    drop_table :navigations
  end
end
