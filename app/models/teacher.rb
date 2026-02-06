# app/models/teacher.rb
class Teacher < ApplicationRecord
  belongs_to :user
  has_many :courses, dependent: :destroy
  
  validates :employee_number, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
end