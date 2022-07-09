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
end