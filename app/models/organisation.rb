class Organisation < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships

  validates :name, uniqueness: true
end
