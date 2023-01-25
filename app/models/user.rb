class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :students, dependent: :destroy
  has_many :course_classes, through: :students

  def first_name
    names.split(" ").first
  end

  def full_name
    "#{names} #{last_names}"
  end

  def username
    email.split("@").first
  end
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
#  status                 :integer          default(0)
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
