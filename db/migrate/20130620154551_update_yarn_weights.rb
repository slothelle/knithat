class UpdateYarnWeights < ActiveRecord::Migration
  def change
    add_column :yarn_weights, :yardage_factor, :integer 
  end
end
