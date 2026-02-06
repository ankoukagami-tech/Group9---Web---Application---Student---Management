class CreateTeachers < ActiveRecord::Migration[8.1]
  def change
    create_table :teachers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :employee_number, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :department
      t.date :hire_date
      
      t.timestamps
    end
    
    add_index :teachers, :employee_number, unique: true
  end
end