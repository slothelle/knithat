class CreateNeedles < ActiveRecord::Migration
  def change
    create_table :needles to |t|
      t.string :size
    end
  end
end
