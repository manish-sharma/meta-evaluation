# == Schema Information
#
# Table name: organizations
#
#  id                :integer          not null, primary key
#  name              :string           not null
#  description       :text
#  domain_name       :string           not null
#  organization_type :integer          not null
#  access_key        :string
#  created_by        :string           not null
#  updated_by        :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Organization < ApplicationRecord
  validates :domain_name, presence: true, uniqueness: true
  validates :name, presence: true, length: { minimum: 2 }
  validates :organization_type, presence: true

  after_save :generate_access_key, unless: Proc.new { |organization| organization.access_key.present? }

  enum organization_type: [ :school, :college ]

  def data_for_access_key
    {
      :id => id,
      :dn => domain_name
    }
  end

  def generate_access_key
    self.access_key = AccessKey.get_key data_for_access_key
    self.save
  end

end
