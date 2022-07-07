class AddDirectorsToFilms < ActiveRecord::Migration[5.2]
  def change
    add_reference :films, :director, foreign_key: true
  end
end
