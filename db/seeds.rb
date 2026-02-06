# db/seeds.rb
puts "Creating roles..."
admin_role = Role.find_or_create_by!(name: 'admin', description: 'System Administrator')
teacher_role = Role.find_or_create_by!(name: 'teacher', description: 'Course Instructor')
student_role = Role.find_or_create_by!(name: 'student', description: 'Registered Student')

puts "Creating admin user..."
admin_user = User.find_or_create_by!(email: 'admin@example.com') do |user|
  user.password = 'admin@123'
  user.role = admin_role
end

admin_student = Student.find_or_create_by!(user: admin_user, student_number: 'ADMIN001') do |student|
  student.first_name = 'System'
  student.last_name = 'Administrator'
end

puts "Creating sample teacher..."
teacher_user = User.find_or_create_by!(email: 'teacher@example.com') do |user|
  user.password = 'teacher@123'
  user.role = teacher_role
end

teacher = Teacher.find_or_create_by!(user: teacher_user, employee_number: 'TEACH001') do |t|
  t.first_name = 'John'
  t.last_name = 'Doe'
  t.department = 'Computer Science'
end

puts "Creating sample course..."
course = Course.find_or_create_by!(code: 'CS101') do |c|
  c.title = 'Introduction to Computer Science'
  c.description = 'Basic programming concepts'
  c.credits = 3
  c.teacher = teacher
  c.semester = 'Fall'
  c.year = 2026
  c.max_capacity = 30
end

puts "Creating sample student..."
student_user = User.find_or_create_by!(email: 'student@example.com') do |user|
  user.password = 'student@123'
  user.role = student_role
end

student = Student.find_or_create_by!(user: student_user, student_number: 'STUD001') do |s|
  s.first_name = 'Jane'
  s.last_name = 'Smith'
  s.enrollment_date = Date.today
end

puts "Sample data created successfully!"