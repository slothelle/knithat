class CreateYarns < ActiveRecord::Migration
  def change
    create_table :yarn do |t|
      t.string :brand
      t.integer :yarn_weight_id
      t.string :color
      t.integer :yards
    end 
  end
end
