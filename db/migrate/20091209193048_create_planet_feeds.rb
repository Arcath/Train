class CreatePlanetFeeds < ActiveRecord::Migration
  def self.up
    create_table :planet_feeds do |t|
      t.string :name
      t.string :url
      t.string :site

      t.timestamps
    end
  end

  def self.down
    drop_table :planet_feeds
  end
end
