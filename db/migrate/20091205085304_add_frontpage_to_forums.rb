class AddFrontpageToForums < ActiveRecord::Migration
  def self.up
    add_column :forums, :frontpage, :boolean
  end

  def self.down
    remove_column :forums, :frontpage
  end
end
