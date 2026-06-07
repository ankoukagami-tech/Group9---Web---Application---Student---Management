class CreateEnrollments < ActiveRecord::Migration[8.1]
  def change
    create_table :enrollments do |t|
      t.references :student, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.decimal :grade
      t.string :status, default: 'enrolled'
      t.datetime :enrollment_date
      
      t.timestamps
    end
    
    add_index :enrollments, [:student_id, :course_id], unique: true
  end
end