class CreateSystems < ActiveRecord::Migration
  def self.up
    create_table :systems do |t|
      t.string :variable
      t.string :value

      t.timestamps
    end
    name=System.new
    name.variable="sitename"
    name.value="TrainCMS"
    name.save
  end

  def self.down
    drop_table :systems
  end
end
