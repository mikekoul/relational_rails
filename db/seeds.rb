Director.destroy_all
Films.destroy_all

kubrick = Director.create!(name: 'Stanley Kubrick', academy_awards: 13, deceased: true)
carpenter = Director.create!(name: 'John Carpenter', academy_awards: 0, deceased: false)
jackson = Director.create!(name: 'Peter Jackson', academy_awards: 9, deceased: false)
toro = Director.create!(name: 'Guillermo del Toro', academy_awards: 6, deceased: false)

kubrick.films.create!(name: 'The Shining', runtime: 146, streaming_on_netflix: true)
kubrick.films.create!(name: 'Full Metal Jacket', runtime: 116, streaming_on_netflix: true)
kubrick.films.create!(name: 'A Clockwork Orange', runtime: 136, streaming_on_netflix: false)
carpenter.films.create!(name: 'Halloween', runtime: 91, streaming_on_netflix: false)
carpenter.films.create!(name: 'Vampires', runtime: 103, streaming_on_netflix: true)
carpenter.films.create!(name: 'Ghosts of Mars', runtime: 98, streaming_on_netflix: false)
toro.films.create!(name: 'Pans Labyrinth', runtime: 110, streaming_on_netflix: false)
toro.films.create!(name: 'Crimson Peak', runtime: 119, streaming_on_netflix: false)
toro.films.create!(name: 'The Shape of Water', runtime: 123, streaming_on_netflix: true)
jackson.films.create!(name: 'The Hobbit', runtime: 169, streaming_on_netflix: true)
jackson.films.create!(name: 'King Kong', runtime: 201, streaming_on_netflix: true)
jackson.films.create!(name: 'Lord of the Rings', runtime: 178, streaming_on_netflix: true)

