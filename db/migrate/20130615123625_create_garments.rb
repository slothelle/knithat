class CreateGarments < ActiveRecord::Migration
  def change
    create_table :garments do |t|
      t.string :type
    end
  end
end
