# app/models/course.rb
class Course < ApplicationRecord
  belongs_to :teacher
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments
  
  validates :title, :code, presence: true
  validates :code, uniqueness: true
  validates :credits, numericality: { greater_than: 0, allow_nil: true }
end