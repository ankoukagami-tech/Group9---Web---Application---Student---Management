# app/models/role.rb
class Role < ApplicationRecord
  has_many :users, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
  
  def self.admin
    find_or_create_by(name: 'admin')
  end
  
  def self.teacher
    find_or_create_by(name: 'teacher')
  end
  
  def self.student
    find_or_create_by(name: 'student')
  end
end