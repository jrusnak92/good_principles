class AddUidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uid, :bigint
  end
end
