# db/seeds.rb

puts "Creating roles..."

admin_role = Role.find_or_create_by!(name: 'admin') do |role|
  role.description = 'System Administrator'
end

teacher_role = Role.find_or_create_by!(name: 'teacher') do |role|
  role.description = 'Course Instructor'
end

student_role = Role.find_or_create_by!(name: 'student') do |role|
  role.description = 'Registered Student'
end

puts "Creating admin user..."

admin_user = User.find_or_create_by!(email: 'admin@example.com') do |user|
  user.password = 'admin@123'
  user.role = admin_role
end

Student.find_or_create_by!(
  user: admin_user,
  student_number: 'ADMIN001'
) do |student|
  student.first_name = 'System'
  student.last_name = 'Administrator'
  student.status = 'active'
end

puts "Creating teacher..."

teacher_user = User.find_or_create_by!(email: 'teacher@example.com') do |user|
  user.password = 'teacher@123'
  user.role = teacher_role
end

teacher = Teacher.find_or_create_by!(
  user: teacher_user,
  employee_number: 'TEACH001'
) do |t|
  t.first_name = 'John'
  t.last_name = 'Doe'
  t.department = 'Computer Science'
  t.hire_date = Date.today
end

puts "Creating student..."

student_user = User.find_or_create_by!(email: 'student@example.com') do |user|
  user.password = 'student@123'
  user.role = student_role
end

student = Student.find_or_create_by!(
  user: student_user,
  student_number: 'STUD001'
) do |s|
  s.first_name = 'Jane'
  s.last_name = 'Smith'
  s.enrollment_date = Date.today
  s.status = 'active'
end

puts "Creating courses..."

cs101 = Course.find_or_create_by!(code: 'CS101') do |c|
  c.title = 'Programming Fundamentals'
  c.description = 'Introduction to programming concepts'
  c.credits = 3
  c.teacher = teacher
  c.semester = 'Fall'
  c.year = 2026
  c.max_capacity = 30
end

cs201 = Course.find_or_create_by!(code: 'CS201') do |c|
  c.title = 'Database Systems'
  c.description = 'Relational databases and SQL'
  c.credits = 3
  c.teacher = teacher
  c.semester = 'Fall'
  c.year = 2026
  c.max_capacity = 30
end

cs301 = Course.find_or_create_by!(code: 'CS301') do |c|
  c.title = 'Web Development'
  c.description = 'Modern web application development'
  c.credits = 4
  c.teacher = teacher
  c.semester = 'Fall'
  c.year = 2026
  c.max_capacity = 30
end

puts "Enrolling student in courses..."

Enrollment.find_or_create_by!(
  student: student,
  course: cs101
) do |e|
  e.status = 'enrolled'
end

Enrollment.find_or_create_by!(
  student: student,
  course: cs201
) do |e|
  e.status = 'enrolled'
end

Enrollment.find_or_create_by!(
  student: student,
  course: cs301
) do |e|
  e.status = 'enrolled'
end

puts "Sample data created successfully!"