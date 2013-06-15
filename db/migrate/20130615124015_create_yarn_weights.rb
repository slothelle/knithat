class CreateYarnWeights < ActiveRecord::Migration
  def change
    create_table :yarnweights do |t|
      t.string :weight
    end 
  end
end
