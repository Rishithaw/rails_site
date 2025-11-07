class CreateTraits < ActiveRecord::Migration[8.0]
  def change
    create_table :traits do |t|
      t.string :name

      t.timestamps
    end
  end
end
