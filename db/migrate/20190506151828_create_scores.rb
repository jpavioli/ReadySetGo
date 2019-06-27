class CreateScores < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.integer :score
      t.integer :event_id
      t.integer :team_id
      t.timestamps
    end
  end
end
