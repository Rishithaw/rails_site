class CreateOwners < ActiveRecord::Migration[8.0]
  def change
    create_table :owners do |t|
      t.string :name

      t.timestamps
    end
  end
end
