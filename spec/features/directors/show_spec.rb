require 'rails_helper'

RSpec.describe "Directors show page", type: :feature do
  describe "#director attributes" do
    it "display name of director" do
      kubrick = Director.create!(name: "Stanley Kubrick", academy_awards: 13, deceased: true)
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)

      visit "/directors/#{kubrick.id}"

      expect(page).to have_content(kubrick.name)
      expect(page).to_not have_content(carpenter.name)
    end

    it "display number of academy awards" do
      kubrick = Director.create!(name: "Stanley Kubrick", academy_awards: 13, deceased: true)
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)

      visit "/directors/#{kubrick.id}"

      expect(page).to have_content(kubrick.academy_awards)
      expect(page).to_not have_content(carpenter.name)
    end

    it "display whether they are deceased or not" do
      kubrick = Director.create!(name: "Stanley Kubrick", academy_awards: 13, deceased: true)
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)

      visit "/directors/#{kubrick.id}"

      expect(page).to have_content(kubrick.deceased)
      expect(page).to_not have_content(carpenter.name)
    end

    it "displays the number of films belonging to the director" do
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
      halloween = carpenter.films.create!(name: 'Halloween', runtime: 91, streaming_on_netflix: false)
      vamps = carpenter.films.create!(name: 'Vampires', runtime: 103, streaming_on_netflix: true)
      mars = carpenter.films.create!(name: 'Ghosts of Mars', runtime: 98, streaming_on_netflix: false)

      visit "/directors/#{carpenter.id}"

      expect(page).to have_content("Number of Films: 3")
    end
  end  
  describe "director show page links" do  
    it "has link to director index" do
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)

      visit "/directors/#{carpenter.id}"

      expect(page).to have_link('Director Index')
    end

    it "click director index link and go to director index page" do
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)

      visit "/directors/#{carpenter.id}"

      click_link('Director Index')

      expect(current_path).to eq("/directors")
    end

    it "has link to films index" do
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
      mars = carpenter.films.create!(name: 'Ghosts of Mars', runtime: 98, streaming_on_netflix: false)

      visit "/directors/#{carpenter.id}"

      expect(page).to have_link('Film Index')
    end

    it "click film index link and go to film index page" do
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
      mars = carpenter.films.create!(name: 'Ghosts of Mars', runtime: 98, streaming_on_netflix: false)
      
      visit "/directors/#{carpenter.id}"

      click_link('Film Index')

      expect(current_path).to eq("/films")
    end

    it 'has link to directors films page' do
      jackson = Director.create!(name: 'Peter Jackson', academy_awards: 9, deceased: false)
      hobbit = jackson.films.create!(name: 'The Hobbit', runtime: 169, streaming_on_netflix: true)
      kong = jackson.films.create!(name: 'King Kong', runtime: 201, streaming_on_netflix: true)
      rings = jackson.films.create!(name: 'Lord of the Rings', runtime: 178, streaming_on_netflix: true)

      visit "/directors/#{jackson.id}"

      expect(page).to have_link('Films')
    end

    it 'click film link and go to directors film page' do
      jackson = Director.create!(name: 'Peter Jackson', academy_awards: 9, deceased: false)
      hobbit = jackson.films.create!(name: 'The Hobbit', runtime: 169, streaming_on_netflix: true)
      kong = jackson.films.create!(name: 'King Kong', runtime: 201, streaming_on_netflix: true)
      rings = jackson.films.create!(name: 'Lord of the Rings', runtime: 178, streaming_on_netflix: true)

      visit "/directors/#{jackson.id}"

      click_link('Films')

      expect(current_path).to eq("/directors/#{jackson.id}/films")
    end

    it 'has link to Update director show page' do
      kubrick = Director.create!(name: "Stanley Kubrick", academy_awards: 13, deceased: true)

    visit "/directors/#{kubrick.id}"

    expect(page).to have_link("Update")
    end

    it 'has link to Delete director show page' do
      toro = Director.create!(name: 'Guillermo del Toro', academy_awards: 6, deceased: false)
      pans = toro.films.create!(name: 'Pans Labyrinth', runtime: 110, streaming_on_netflix: false)
      peak = toro.films.create!(name: 'Crimson Peak', runtime: 119, streaming_on_netflix: false)
      water = toro.films.create!(name: 'The Shape of Water', runtime: 123, streaming_on_netflix: true)

      visit "/directors/#{toro.id}"

      expect(page).to have_button("Delete")
    end

    it 'click delete button to delete director show page' do
      kubrick = Director.create!(name: 'Stanley Kubrick', academy_awards: 13, deceased: true)
      carpenter = Director.create!(name: 'John Carpenter', academy_awards: 0, deceased: false)
      jackson = Director.create!(name: 'Peter Jackson', academy_awards: 9, deceased: false)
      toro = Director.create!(name: 'Guillermo del Toro', academy_awards: 6, deceased: false)
      pans = toro.films.create!(name: 'Pans Labyrinth', runtime: 110, streaming_on_netflix: false)
      peak = toro.films.create!(name: 'Crimson Peak', runtime: 119, streaming_on_netflix: false)
      water = toro.films.create!(name: 'The Shape of Water', runtime: 123, streaming_on_netflix: true)

      visit "/directors/#{toro.id}"

      click_button("Delete")
      
      expect(current_path).to eq("/directors")
      expect(page).to_not have_content(toro.name)
    end
  end
end