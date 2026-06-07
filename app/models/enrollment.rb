# app/models/enrollment.rb
class Enrollment < ApplicationRecord
  belongs_to :student
  belongs_to :course
  
  validates :student_id, uniqueness: { scope: :course_id }
  validates :status, inclusion: { in: %w[enrolled completed dropped] }
  
  before_create :set_enrollment_date
  
  private
  
  def set_enrollment_date
    self.enrollment_date ||= Time.current
  end
end