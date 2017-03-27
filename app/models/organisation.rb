# == Schema Information
#
# Table name: organisations
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  subdomain  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slack_uid  :string
#  image_url  :string
#

class Organisation < ActiveRecord::Base
  has_many :users

  validates :name, presence: true
  validates :subdomain,
            presence: true,
            format: { with: /\A[a-z][a-z0-9\-]+[a-z0-9]\Z/ },
            uniqueness: true
