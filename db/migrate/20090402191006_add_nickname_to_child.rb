class AddNicknameToChild < ActiveRecord::Migration
  def self.up
    add_column :children, :nickname, :string
  end

  def self.down
    remove_column :children, :nickname
  end
end
