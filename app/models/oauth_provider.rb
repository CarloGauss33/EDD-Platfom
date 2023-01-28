class OauthProvider < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }

  enum provider: { google_oauth2: 0 }
end

# == Schema Information
#
# Table name: oauth_providers
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)        not null
#  provider   :integer          not null
#  uid        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_oauth_providers_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
