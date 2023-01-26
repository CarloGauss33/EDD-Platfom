class ConfigVariable < ApplicationRecord
  validates :key, presence: true

  enum value_type: {
    string: 0,
    integer: 1,
    boolean: 2,
    date: 3
  }

  def casted_value
    case value_type
    when 'string'
      value
    when 'integer'
      value.to_i
    when 'boolean'
      value == 'true'
    when 'date'
      Date.parse(value)
    end
  end

  def self.fetch(key, default_value = nil)
    if default_value.present?
      find_by(key: key)&.casted_value || default_value
    else
      find_by!(key: key).casted_value
    end
  end
end

# == Schema Information
#
# Table name: config_variables
#
#  id          :bigint(8)        not null, primary key
#  name        :string           not null
#  key         :string           not null
#  value_type  :integer          not null
#  value       :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
