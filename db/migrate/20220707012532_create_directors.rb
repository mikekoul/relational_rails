class CreateDirectors < ActiveRecord::Migration[5.2]
  def change
    create_table :directors do |t|
      t.string :name
      t.integer :academy_awards
      t.boolean :deceased
      t.timestamps
    end
  end
end
