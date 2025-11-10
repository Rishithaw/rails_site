class CreateDogsTraits < ActiveRecord::Migration[8.0]
  def change
    create_table :dog_traits do |t|
      t.references :dog, null: false, foreign_key: true
      t.references :trait, null: false, foreign_key: true

      t.timestamps
    end
  end
end
