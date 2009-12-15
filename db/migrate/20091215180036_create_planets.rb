class CreatePlanets < ActiveRecord::Migration
  def self.up
    create_table :planets do |t|
      t.string :name
      t.text :summary
      t.string :url
      t.datetime :published_at
      t.string :guid

      t.timestamps
    end
  end

  def self.down
    drop_table :planets
  end
end
