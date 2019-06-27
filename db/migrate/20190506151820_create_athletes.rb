class CreateAthletes < ActiveRecord::Migration[5.2]
  def change
    create_table :athletes do |t|
      t.string :first_name
      t.string :last_name
      t.string :hometown
      t.string :state
      t.string :bio
      t.string :gender
      t.integer :jersey_number
      t.integer :age
      t.integer :weight
      t.integer :height
      t.integer :team_id
      t.timestamps
    end
  end
end
