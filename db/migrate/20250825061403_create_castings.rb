class CreateCastings < ActiveRecord::Migration[8.0]
  def change
    create_table :castings do |t|
      t.string :role
      t.references :movie, null: false, foreign_key: true
      t.references :actor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
