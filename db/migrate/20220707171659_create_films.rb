class CreateFilms < ActiveRecord::Migration[5.2]
  def change
    create_table :films do |t|
      t.string :name
      t.integer :runtime
      t.boolean :streaming_on_netflix
      
      t.timestamps
    end
  end
end
