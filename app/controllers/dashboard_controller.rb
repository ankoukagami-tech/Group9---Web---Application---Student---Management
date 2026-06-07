# app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  def index
    case @current_user.role.name
    when 'admin'
      admin_dashboard
    when 'teacher'
      teacher_dashboard
    when 'student'
      student_dashboard
    end
  end
  
  private
  
  def admin_dashboard
    @total_students = Student.count
    @total_courses = Course.count
    @total_teachers = Teacher.count
    @recent_enrollments = Enrollment.includes(:student, :course).limit(5)
  end
  
  def teacher_dashboard
    @courses = @current_user.teacher.courses
    @students_count = @courses.joins(:students).distinct.count
    @enrolled_students = Student.joins(:enrollments => :course).where(courses: { teacher: @current_user.teacher }).distinct
  end
  
  def student_dashboard
    @enrolled_courses = @current_user.student.courses
  end
end