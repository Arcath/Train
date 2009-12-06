class AddPermissionsToForums < ActiveRecord::Migration
  def self.up
    add_column :forums, :canviews_mask, :integer
    add_column :forums, :canposts_mask, :integer
    add_column :forums, :cantopics_mask, :integer
    add_column :forums, :canmoderates_mask, :integer
  end

  def self.down
    remove_column :forums, :canviews_mask
    remove_column :forums, :canmoderates_mask
    remove_column :forums, :cantopics_mask
    remove_column :forums, :canposts_mask
  end
end
