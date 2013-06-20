class UpdateYarnWeights < ActiveRecord::Migration
  def change
    add_column :yarn_weights, :yardage_factor, :string 
  end
end
