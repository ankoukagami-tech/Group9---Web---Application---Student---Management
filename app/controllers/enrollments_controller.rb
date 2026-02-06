# app/controllers/enrollments_controller.rb
class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: [:edit, :update, :destroy]
  
  def index
    if @current_user.role.name == 'admin'
      @enrollments = Enrollment.includes(:student, :course).page(params[:page]).per(10)
    elsif @current_user.role.name == 'teacher'
      @enrollments = Enrollment.joins(:course).where(courses: { teacher: @current_user.teacher }).includes(:student, :course).page(params[:page]).per(10)
    else
      redirect_to root_path, alert: 'Access denied.'
    end
  end
  
  def new
    if @current_user.role.name == 'admin'
      @enrollment = Enrollment.new
      @students = Student.all
      @courses = Course.all
    elsif @current_user.role.name == 'teacher'
      @enrollment = Enrollment.new
      @students = Student.joins(:enrollments => :course).where(courses: { teacher: @current_user.teacher }).distinct
      @courses = @current_user.teacher.courses
    else
      redirect_to root_path, alert: 'Access denied.'
    end
  end
  
  def create
    if @current_user.role.name == 'admin'
      @enrollment = Enrollment.new(enrollment_params)
    elsif @current_user.role.name == 'teacher'
      # Teachers can only create enrollments for their own courses
      @enrollment = Enrollment.new(enrollment_params)
      course = Course.find(enrollment_params[:course_id])
      unless course.teacher == @current_user.teacher
        redirect_to root_path, alert: 'Access denied.'
        return
      end
    else
      redirect_to root_path, alert: 'Access denied.'
      return
    end
    
    if @enrollment.save
      redirect_to enrollments_path, notice: 'Student enrolled successfully!'
    else
      if @current_user.role.name == 'admin'
        @students = Student.all
        @courses = Course.all
      elsif @current_user.role.name == 'teacher'
        @students = Student.joins(:enrollments => :course).where(courses: { teacher: @current_user.teacher }).distinct
        @courses = @current_user.teacher.courses
      end
      render :new
    end
  end
  
  def edit
    # Allow teachers to edit only their own course enrollments
    if @current_user.role.name == 'teacher'
      unless @enrollment.course.teacher == @current_user.teacher
        redirect_to root_path, alert: 'Access denied.'
        return
      end
    end
  end
  
  def update
    # Allow teachers to update only their own course enrollments
    if @current_user.role.name == 'teacher'
      unless @enrollment.course.teacher == @current_user.teacher
        redirect_to root_path, alert: 'Access denied.'
        return
      end
    end
    
    if @enrollment.update(enrollment_params)
      redirect_to dashboard_path, notice: 'Enrollment updated successfully!'
    else
      render :edit
    end
  end
  
  def destroy
    if @current_user.role.name != 'admin'
      redirect_to root_path, alert: 'Access denied.'
    else
      @enrollment.destroy
      redirect_to enrollments_path, notice: 'Enrollment removed successfully!'
    end
  end
  
  def my_courses
    if @current_user.role.name == 'student'
      @enrollments = @current_user.student.enrollments.includes(:course)
    else
      redirect_to root_path, alert: 'Access denied.'
    end
  end
  
  private
  
  def set_enrollment
    @enrollment = Enrollment.find(params[:id])
  end
  
  def enrollment_params
    params.require(:enrollment).permit(:student_id, :course_id, :status, :grade)
  end
end