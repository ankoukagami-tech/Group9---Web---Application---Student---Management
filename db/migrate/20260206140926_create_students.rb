class CreateStudents < ActiveRecord::Migration[8.1]
  def change
    create_table :students do |t|
      t.references :user, null: false, foreign_key: true
      t.string :student_number, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.date :date_of_birth
      t.string :gender
      t.text :address
      t.string :phone
      t.string :emergency_contact
      t.date :enrollment_date
      t.string :status, default: 'active'
      
      t.timestamps
    end
    
    add_index :students, :student_number, unique: true
  end
end