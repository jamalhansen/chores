class CreateIdentities < ActiveRecord::Migration
  def self.up
    create_table :identities do |t|
      t.string :identifier, :null => false, :limit => 100

      t.timestamps
    end
  end

  def self.down
    drop_table :identities
  end
end
