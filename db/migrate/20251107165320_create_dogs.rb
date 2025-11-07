class CreateDogs < ActiveRecord::Migration[8.0]
  def change
    create_table :dogs do |t|
      t.string :name
      t.references :owner, null: false, foreign_key: true
      t.references :sub_breed, null: false, foreign_key: true

      t.timestamps
    end
  end
end
