class CreateGarments < ActiveRecord::Migration
  def change
    create_table :garments do |t|
      t.string :category
    end
  end
end
