# app/controllers/students_controller.rb
class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  
  def index
    if @current_user.role.name == 'admin'
      @students = Student.includes(:user).page(params[:page]).per(10)
    elsif @current_user.role.name == 'teacher'
      @students = Student.joins(:enrollments => :course).where(courses: { teacher: @current_user.teacher }).distinct.page(params[:page]).per(10)
    else
      redirect_to root_path, alert: 'Access denied.'
    end
  end
  
  def show
    if @current_user.role.name == 'admin'
      # Admin can see any student
    elsif @current_user.role.name == 'teacher'
      # Teacher can only see students in their courses
      unless @student.enrollments.joins(:course).exists?(courses: { teacher: @current_user.teacher })
        redirect_to root_path, alert: 'Access denied.'
        return
      end
    else
      redirect_to root_path, alert: 'Access denied.'
    end
  end
  
  def new
    if @current_user.role.name != 'admin'
      redirect_to root_path, alert: 'Access denied.'
    else
      @student = Student.new
      @user = @student.build_user
    end
  end
  
  def create
    if @current_user.role.name != 'admin'
      redirect_to root_path, alert: 'Access denied.'
      return
    end
    
    @user = User.new(user_params)
    @student = Student.new(student_params)
    @student.user = @user
    
    if @user.save && @student.save
      redirect_to students_path, notice: 'Student created successfully!'
    else
      render :new
    end
  end
  
  def edit
    if @current_user.role.name == 'admin'
      # Admin can edit any student
    elsif @current_user.role.name == 'teacher'
      # Teacher can only edit students in their courses
      unless @student.enrollments.joins(:course).exists?(courses: { teacher: @current_user.teacher })
        redirect_to root_path, alert: 'Access denied.'
        return
      end
    else
      redirect_to root_path, alert: 'Access denied.'
    end
    
    @user = @student.user
  end
  
  def update
    if @current_user.role.name == 'admin'
      # Admin can update any student
    elsif @current_user.role.name == 'teacher'
      # Teacher can only update students in their courses
      unless @student.enrollments.joins(:course).exists?(courses: { teacher: @current_user.teacher })
        redirect_to root_path, alert: 'Access denied.'
        return
      end
    else
      redirect_to root_path, alert: 'Access denied.'
    end
    
    @user = @student.user
    
    if @student.update(student_params) && @user.update(user_update_params)
      redirect_to students_path, notice: 'Student updated successfully!'
    else
      render :edit
    end
  end
  
  def destroy
    if @current_user.role.name != 'admin'
      redirect_to root_path, alert: 'Access denied.'
    else
      @student.destroy
      redirect_to students_path, notice: 'Student deleted successfully!'
    end
  end
  
  private
  
  def set_student
    @student = Student.find(params[:id])
  end
  
  def student_params
    params.require(:student).permit(:first_name, :last_name, :date_of_birth, :gender, :address, :phone, :emergency_contact, :status, :student_number)
  end
  
  def user_params
    params.require(:student).permit(:email, :password, :password_confirmation).merge(role: Role.find_by(name: 'student'))
  end
  
  def user_update_params
    params.require(:student).permit(:email, :password, :password_confirmation)
  end
end