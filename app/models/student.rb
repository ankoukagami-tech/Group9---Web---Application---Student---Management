# app/models/student.rb
class Student < ApplicationRecord
  belongs_to :user
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments
  
  validates :student_number, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
  validates :status, inclusion: { in: %w[active inactive] }
end