# app/models/user.rb
class User < ApplicationRecord
  belongs_to :role
  has_one :student, dependent: :destroy
  has_one :teacher, dependent: :destroy
  
  has_secure_password
  
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: :password_required?
  
  private
  
  def password_required?
    new_record? || password.present?
  end
end