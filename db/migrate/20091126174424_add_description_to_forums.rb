class AddDescriptionToForums < ActiveRecord::Migration
  def self.up
    add_column :forums, :description, :text
  end

  def self.down
    remove_column :forums, :description
  end
end
