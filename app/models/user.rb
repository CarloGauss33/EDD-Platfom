class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :students, dependent: :destroy
  has_many :course_classes, through: :students
  has_many :oauth_providers, dependent: :destroy

  def first_name
    names.split(" ").first
  end

  def full_name
    "#{names} #{last_names}"
  end

  def username
    email.split("@").first
  end

  def self.by_provider_and_uid(provider, uid)
    joins(:oauth_providers).where(oauth_providers: { provider: provider, uid: uid })
  end

  def self.create_from_provider_data(auth)
    user = by_provider_and_uid(auth.provider, auth.uid).first

    if user.nil?
      user = User.find_by(email: auth.info.email)
      if user.nil?
        user = User.create(
          email: auth.info.email,
          names: auth.info.first_name,
          last_names: auth.info.last_name,
          password: Devise.friendly_token[0, 20]
        )
      end
      user.oauth_providers.create(provider: auth.provider, uid: auth.uid)
    end

    user
  end

  enum status: { active: 0, inactive: 1 }
end
# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  names                  :string
#  last_names             :string
#  status                 :integer          default("active")
#  canvas_user_id         :string
#  university_id          :string
#  rut                    :string
#  github_username        :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
