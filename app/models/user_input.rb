class UserInput < ActiveRecord::Base
  belongs_to :user
  belongs_to :needle
  belongs_to :garment
  belongs_to :yarn
end
