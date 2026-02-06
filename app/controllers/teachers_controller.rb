# app/controllers/teachers_controller.rb
class TeachersController < ApplicationController
  before_action :authorize_admin!
  before_action :set_teacher, only: [:show, :edit, :update, :destroy]
  
  def index
    @teachers = Teacher.includes(:user).page(params[:page]).per(10)
  end
  
  def show
    if @current_user.role.name != 'admin' && @current_user.teacher != @teacher
      redirect_to root_path, alert: 'Access denied.'
    end
  end
  
  def new
    @teacher = Teacher.new
    @user = @teacher.build_user
  end
  
  def create
    @user = User.new(user_params)
    @teacher = Teacher.new(teacher_params)
    @teacher.user = @user
    
    if @user.save && @teacher.save
      redirect_to teachers_path, notice: 'Teacher created successfully!'
    else
      render :new
    end
  end
  
  def edit
    @user = @teacher.user
    if @current_user.role.name != 'admin' && @current_user.teacher != @teacher
      redirect_to root_path, alert: 'Access denied.'
    end
  end
  
  def update
    @user = @teacher.user
    
    if @current_user.role.name != 'admin' && @current_user.teacher != @teacher
      redirect_to root_path, alert: 'Access denied.'
      return
    end
    
    if @teacher.update(teacher_params) && @user.update(user_update_params)
      redirect_to teachers_path, notice: 'Teacher updated successfully!'
    else
      render :edit
    end
  end
  
  def destroy
    if @current_user.role.name != 'admin'
      redirect_to root_path, alert: 'Access denied.'
      return
    end
    
    @teacher.destroy
    redirect_to teachers_path, notice: 'Teacher deleted successfully!'
  end
  
  private
  
  def set_teacher
    @teacher = Teacher.find(params[:id])
  end
  
  def teacher_params
    params.require(:teacher).permit(:first_name, :last_name, :department, :hire_date, :employee_number)
  end
  
  def user_params
    params.require(:teacher).permit(:email, :password, :password_confirmation).merge(role: Role.find_by(name: 'teacher'))
  end
  
  def user_update_params
    params.require(:teacher).permit(:email, :password, :password_confirmation)
  end
end