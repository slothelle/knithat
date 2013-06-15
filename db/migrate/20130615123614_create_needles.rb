class CreateNeedles < ActiveRecord::Migration
  def change
    create_table :needles do |t|
      t.string :size
    end
  end
end
