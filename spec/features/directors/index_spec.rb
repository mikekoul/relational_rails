require 'rails_helper'

RSpec.describe "directors index page", type: :feature do
  it "can see names of all directors" do
    kubrick = Director.create!(name: "Stanley Kubrick", academy_awards: 13, deceased: true)
    carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
    jackson = Director.create!(name: "Peter Jackson", academy_awards: 9, deceased: false)
    toro = Director.create!(name: "Guillermo del Toro", academy_awards: 6, deceased: false)

    visit "/directors"

    expect(page).to have_content("Stanley Kubrick")
    expect(page).to have_content("John Carpenter")
    expect(page).to have_content("Peter Jackson")
    expect(page).to have_content("Guillermo del Toro")
  end

  it "displays directors by most recently created" do
    kubrick = Director.create!(name: "Stanley Kubrick", academy_awards: 13, deceased: true)
    carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
    jackson = Director.create!(name: "Peter Jackson", academy_awards: 9, deceased: false)
    toro = Director.create!(name: "Guillermo del Toro", academy_awards: 6, deceased: false)

    visit "/directors"

    within "#director0" do
      expect(page).to have_content("Guillermo del Toro")
    end

    within "#director1" do
      expect(page).to have_content("Peter Jackson")
    end

    within "#director2" do
      expect(page).to have_content("John Carpenter")
    end

    within "#director3" do
      expect(page).to have_content("Stanley Kubrick")
    end
  end

  describe "#directors index links" do  
    it "has link to director index" do
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)

      visit "/directors"

      expect(page).to have_link('Director Index')
    end

    it "click director index link and go to director index page" do
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)

      visit "/directors"

      click_link('Director Index')

      expect(current_path).to eq("/directors")
    end

    it "has link to films index" do
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
      mars = carpenter.films.create!(name: 'Ghosts of Mars', runtime: 98, streaming_on_netflix: false)

      visit "/directors"

      expect(page).to have_link('Film Index')
    end

    it "click film index link and go to film index page" do
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
      mars = carpenter.films.create!(name: 'Ghosts of Mars', runtime: 98, streaming_on_netflix: false)

      visit "/directors"

      click_link('Film Index')

      expect(current_path).to eq("/films")
    end

    it "has link to create new director" do
      kubrick = Director.create!(name: 'Stanley Kubrick', academy_awards: 13, deceased: true)
      carpenter = Director.create!(name: 'John Carpenter', academy_awards: 0, deceased: false)
      jackson = Director.create!(name: 'Peter Jackson', academy_awards: 9, deceased: false)
      toro = Director.create!(name: 'Guillermo del Toro', academy_awards: 6, deceased: false)

      visit "/directors"

      expect(page).to have_link('New Director')
    end

    it "has links to edit director" do
      kubrick = Director.create!(name: 'Stanley Kubrick', academy_awards: 13, deceased: true)
      carpenter = Director.create!(name: 'John Carpenter', academy_awards: 0, deceased: false)
      jackson = Director.create!(name: 'Peter Jackson', academy_awards: 9, deceased: false)
      toro = Director.create!(name: 'Guillermo del Toro', academy_awards: 6, deceased: false)

      visit "/directors"

      within "#director0" do
      expect(page).to have_link("Edit")

      click_link "Edit"

      expect(current_path).to eq("/directors/#{toro.id}/edit")
      end

      visit "/directors"

      within "#director1" do
        expect(page).to have_link("Edit")

        click_link "Edit"

        expect(current_path).to eq("/directors/#{jackson.id}/edit")
      end

      visit "/directors"

      within "#director2" do
        expect(page).to have_link("Edit")

        click_link "Edit"

        expect(current_path).to eq("/directors/#{carpenter.id}/edit")
      end

      visit "/directors"

      within "#director3" do
        expect(page).to have_link("Edit")

        click_link "Edit"

        expect(current_path).to eq("/directors/#{kubrick.id}/edit")
      end
    end

    it 'has button to delete directors' do
      kubrick = Director.create!(name: 'Stanley Kubrick', academy_awards: 13, deceased: true)
      carpenter = Director.create!(name: 'John Carpenter', academy_awards: 0, deceased: false)
      jackson = Director.create!(name: 'Peter Jackson', academy_awards: 9, deceased: false)
      toro = Director.create!(name: 'Guillermo del Toro', academy_awards: 6, deceased: false)

      visit "/directors"
  
      within "#director0" do

        expect(page).to have_button('Delete')
      end

      within "#director1" do

        expect(page).to have_button('Delete')
      end

      within "#director2" do

        expect(page).to have_button('Delete')
      end

      within "#director3" do

        expect(page).to have_button('Delete')
      end
    end
    it 'click button to delete directors' do
      kubrick = Director.create!(name: 'Stanley Kubrick', academy_awards: 13, deceased: true)
      carpenter = Director.create!(name: 'John Carpenter', academy_awards: 0, deceased: false)
      jackson = Director.create!(name: 'Peter Jackson', academy_awards: 9, deceased: false)
      toro = Director.create!(name: 'Guillermo del Toro', academy_awards: 6, deceased: false)

      visit "/directors"
      
      expect(page).to have_content('Guillermo del Toro')

      within "#director0" do

        click_button("Delete")

      end

      visit "/directors"

      expect(page).to_not have_content("Guillermo del Toro")
    end
  end
end