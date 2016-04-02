class PropReceiver < ActiveRecord::Base
  belongs_to :prop
  belongs_to :user

  validates :prop, :user, presence: true
end
