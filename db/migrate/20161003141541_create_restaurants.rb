class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.integer :rating
      t.text :address
      t.text :description

      t.timestamps
    end
  end
end
