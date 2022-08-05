class User < ApplicationRecord
  include JwtToken
  authenticates_with_sorcery!
  
  has_many :poses, dependent: :destroy
  has_one :pure_pose, dependent: :destroy
  has_many :results, dependent: :destroy

  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true

  enum role: { general: 0, admin: 1 }
end
