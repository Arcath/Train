class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.string :title
      t.text :body
      t.boolean :sender_delete
      t.boolean :receiver_delete
      t.boolean :read

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
