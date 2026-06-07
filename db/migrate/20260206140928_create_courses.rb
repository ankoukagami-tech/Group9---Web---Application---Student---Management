class CreateCourses < ActiveRecord::Migration[8.1]
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.string :code, null: false
      t.text :description
      t.integer :credits
      t.references :teacher, null: false, foreign_key: true
      t.string :semester
      t.integer :year
      t.integer :max_capacity
      
      t.timestamps
    end
    
    add_index :courses, :code, unique: true
  end
end