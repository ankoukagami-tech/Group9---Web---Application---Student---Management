# app/controllers/courses_controller.rb
class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  
  def index
    if @current_user.role.name == 'admin'
      @courses = Course.includes(:teacher).page(params[:page]).per(10)
    elsif @current_user.role.name == 'teacher'
      @courses = @current_user.teacher.courses.page(params[:page]).per(10)
    else
      redirect_to root_path, alert: 'Access denied.'
    end
  end
  
  def show
    if @current_user.role.name == 'admin'
      # Admin can see any course
    elsif @current_user.role.name == 'teacher'
      # Teacher can only see their own courses
      unless @course.teacher == @current_user.teacher
        redirect_to root_path, alert: 'Access denied.'
        return
      end
    else
      redirect_to root_path, alert: 'Access denied.'
    end
  end
  
  def new
    if @current_user.role.name == 'admin'
      @course = Course.new
      @teachers = Teacher.all
    elsif @current_user.role.name == 'teacher'
      @course = Course.new
      @course.teacher = @current_user.teacher
      @teachers = [@current_user.teacher]
    else
      redirect_to root_path, alert: 'Access denied.'
    end
  end
  
  def create
    @course = Course.new(course_params)
    
    # Prevent teachers from creating courses for other teachers
    if @current_user.role.name == 'teacher'
      @course.teacher = @current_user.teacher
    end
    
    if @course.save
      redirect_to courses_path, notice: 'Course created successfully!'
    else
      @teachers = Teacher.all if @current_user.role.name == 'admin'
      @teachers = [@current_user.teacher] if @current_user.role.name == 'teacher'
      render :new
    end
  end
  
  def edit
    if @current_user.role.name == 'admin'
      # Admin can edit any course
      @teachers = Teacher.all
    elsif @current_user.role.name == 'teacher'
      # Teacher can only edit their own courses
      unless @course.teacher == @current_user.teacher
        redirect_to root_path, alert: 'Access denied.'
        return
      end
      @teachers = [@current_user.teacher]
    else
      redirect_to root_path, alert: 'Access denied.'
    end
  end
  
  def update
    if @current_user.role.name == 'admin'
      # Admin can update any course
      @teachers = Teacher.all
    elsif @current_user.role.name == 'teacher'
      # Teacher can only update their own courses
      unless @course.teacher == @current_user.teacher
        redirect_to root_path, alert: 'Access denied.'
        return
      end
      @teachers = [@current_user.teacher]
    end
    
    if @course.update(course_params)
      redirect_to courses_path, notice: 'Course updated successfully!'
    else
      render :edit
    end
  end
  
  def destroy
    if @current_user.role.name != 'admin'
      redirect_to root_path, alert: 'Access denied.'
    else
      @course.destroy
      redirect_to courses_path, notice: 'Course deleted successfully!'
    end
  end
  
  private
  
  def set_course
    @course = Course.find(params[:id])
  end
  
  def course_params
    params.require(:course).permit(:title, :code, :description, :credits, :teacher_id, :semester, :year, :max_capacity)
  end
end