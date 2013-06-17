class UpdateYarns < ActiveRecord::Migration
  def change
    add_column :yarn, :yards, :integer
  end
end
