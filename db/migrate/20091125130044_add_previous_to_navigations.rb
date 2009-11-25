class AddPreviousToNavigations < ActiveRecord::Migration
  def self.up
    add_column :navigations, :previous, :integer
  end

  def self.down
    remove_column :navigations, :previous
  end
end
