class CreateChores < ActiveRecord::Migration
  def self.up
    create_table :chores do |t|
      t.string :description, :null => false, :limit => 255

      t.timestamps
    end
  end

  def self.down
    drop_table :chores
  end
end
