class Test < ActiveRecord::Base
  create_table :tests do |t|
    t.string :name
  end
end
