class CreateYarnWeights < ActiveRecord::Migration
  def change
    create_table :yarn_weights do |t|
      t.string :weight
    end 
  end
end
