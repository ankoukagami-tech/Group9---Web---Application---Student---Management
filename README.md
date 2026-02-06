# Student Management System

A comprehensive student management system built with Ruby on Rails featuring role-based access control, authentication, and full CRUD operations.

## Features

- Role-based access control (Admin, Teacher, Student)
- User authentication and authorization
- Student management (CRUD operations)
- Teacher management (CRUD operations)
- Course management (CRUD operations)
- Enrollment management
- Dashboard for different user roles
- Responsive UI with Bootstrap

## Prerequisites

- Ruby 3.1.0 or higher
- Rails 7.0 or higher
- MySQL (or SQLite for development)
- Node.js and Yarn

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/yourusername/student-management-system.git
cd student-management-system
```

### 2. Install dependencies

```bash
bundle install
yarn install
```

### 3. Database Setup

Option A: Using SQLite (Default)

### Create and migrate database

```bash
rails db:create
rails db:migrate
rails db:seed
```

Option B: Using MySQL

1. Update Gemfile

```ruby
# Comment out sqlite3
# gem 'sqlite3', '~> 1.4'

# Uncomment mysql2
gem 'mysql2', '~> 0.5'
```

2. Update config/database.yml with your MySQL credentials:

```yaml
development:
  adapter: mysql2
  encoding: utf8mb4
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: your_mysql_username
  password: your_mysql_password
  host: localhost
  database: student_management_dev
```

3. Install gems and setup database:

```bash
bundle install
rails db:create
rails db:migrate
rails db:seed
```

### 4. Start the application

```bash
rails server
```

The application will be available at http://localhost:3000

Default Credentials
After seeding the database, the following default accounts are created:

**Admin Account**
- Email: admin@example.com
- Password: password123

**Teacher Account**
- Email: teacher@example.com
- Password: password123

**Student Account**
- Email: student@example.com
- Password: password123

**Usage**
1. Navigate to http://localhost:3000
2. Log in with one of the default accounts or create a new account
3. Access features based on your role:
- Admin: Full access to all features (students, teachers, courses, enrollments)
- Teacher: Manage courses and student grades, view enrolled students
- Student: View enrolled courses and instructors

# Project Structure

```
app/
├── controllers/          # MVC controllers
├── models/              # Database models
├── views/               # View templates
│   ├── layouts/         # Application layout
│   └── sessions/        # Login views
├── helpers/             # View helpers
└── assets/              # CSS, JS, images
config/
├── routes.rb            # Application routes
├── database.yml         # Database configuration
└── application.rb       # Application configuration
db/
├── migrate/             # Database migrations
└── seeds.rb             # Initial data
```

# Available Commands

```bash
# Console access
rails console

# Reset the database
rails db:reset

# Run database migrations
rails db:migrate

# Seed the database with default data
rails db:seed

# Run tests
rails test

# View all routes
rails routes

# Start the development server
rails server
```

## Customization
### Adding New Roles
1. Update the Role model and seeds
2. Add corresponding authorization checks in controllers
3. Update navigation in app/views/layouts/application.html.erb
### Modifying Database Schema
1. Generate new migration: rails generate migration MigrationName
2. Update the migration file
3. Run: rails db:migrate
## Troubleshooting
### Common Issues
1. Bundle install fails: Try bundle update or check Ruby version compatibility
2. Database connection errors: Verify database configuration in config/database.yml
3. Missing assets: Run rails assets:precompile
4. Permission errors: Ensure you have write permissions for the project directory

## Reset Everything

```bash
rails db:drop
rails db:create
rails db:migrate
rails db:seed
```

## Contributing
1. Fork the repository
2. Create a feature branch: git checkout -b feature/AmazingFeature
3. Commit your changes: git commit -m 'Add some AmazingFeature'
4. Push to the branch: git push origin feature/AmazingFeature
5. Open a Pull Request

### License
This project is licensed under the MIT License.

## Acknowledgments
- Ruby on Rails framework
- Bootstrap for styling
- MySQL/SQLite for database

**This README provides comprehensive instructions for anyone to clone and run your project successfully. It covers installation, database setup, default credentials, usage instructions, project structure, and troubleshooting tips.**