require 'rails_helper'

RSpec.describe 'Films index' do
  it 'shows a list of all the films' do
    kubrick = Director.create!(name: 'Stanley Kubrick', academy_awards: 13, deceased: true)
    carpenter = Director.create!(name: 'John Carpenter', academy_awards: 0, deceased: false)
    shining = kubrick.films.create!(name: 'The Shining', runtime: 146, streaming_on_netflix: true)
    vamps = carpenter.films.create!(name: 'Vampires', runtime: 103, streaming_on_netflix: true)

    visit "/films"

    expect(page).to have_content(shining.name)
    expect(page).to have_content(shining.runtime)
    expect(page).to have_content(shining.streaming_on_netflix)
    expect(page).to have_content(vamps.name)
    expect(page).to have_content(vamps.runtime)
    expect(page).to have_content(vamps.streaming_on_netflix)
  end

  describe ('#index links') do
    it "has link to director index" do
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
      vamps = carpenter.films.create!(name: 'Vampires', runtime: 103, streaming_on_netflix: true)

      visit "/films"

      expect(page).to have_link('Director Index')
    end

    it "click director index link and go to director index page" do
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
      vamps = carpenter.films.create!(name: 'Vampires', runtime: 103, streaming_on_netflix: true)

      visit "/films"

      click_link('Director Index')

      expect(current_path).to eq("/directors")
    end

    it "has link to films index" do
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
      mars = carpenter.films.create!(name: 'Ghosts of Mars', runtime: 98, streaming_on_netflix: false)

      visit "/films"

      expect(page).to have_link('Film Index')
    end

    it "click film index link and go to film index page" do
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
      mars = carpenter.films.create!(name: 'Ghosts of Mars', runtime: 98, streaming_on_netflix: false)

      visit "/films"

      click_link('Film Index')

      expect(current_path).to eq("/films")
    end
  end

  describe ('#new_index_view') do
    it 'displays only the films that are streaming on netflix' do
      kubrick = Director.create!(name: 'Stanley Kubrick', academy_awards: 13, deceased: true)
      carpenter = Director.create!(name: 'John Carpenter', academy_awards: 0, deceased: false)
      toro = Director.create!(name: 'Guillermo del Toro', academy_awards: 6, deceased: false)
      shining = kubrick.films.create!(name: 'The Shining', runtime: 146, streaming_on_netflix: true)
      halloween = carpenter.films.create!(name: 'Halloween', runtime: 91, streaming_on_netflix: false)
      peak = toro.films.create!(name: 'Crimson Peak', runtime: 119, streaming_on_netflix: false)
      water = toro.films.create!(name: 'The Shape of Water', runtime: 123, streaming_on_netflix: true)

      visit "/films"

      expect(page).to have_content("The Shining")
      expect(page).to have_content("The Shape of Water")
      expect(page).to_not have_content("Halloween")
      expect(page).to_not have_content("Crimson Peak")
    end
  end

end