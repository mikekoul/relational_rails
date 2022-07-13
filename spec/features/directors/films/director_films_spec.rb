require 'rails_helper'

RSpec.describe "Director films index", type: :feature do
  it "display name of film" do
    kubrick = Director.create!(name: "Stanley Kubrick", academy_awards: 13, deceased: true)
    shining = kubrick.films.create!(name: 'The Shining', runtime: 146, streaming_on_netflix: true)
    fmj = kubrick.films.create!(name: 'Full Metal Jacket', runtime: 116, streaming_on_netflix: true)

    visit "/directors/#{kubrick.id}/films"

    expect(page).to have_content(shining.name)
    expect(page).to have_content(shining.runtime)
    expect(page).to have_content(shining.streaming_on_netflix)
    expect(page).to have_content(fmj.name)
    expect(page).to have_content(fmj.runtime)
    expect(page).to have_content(fmj.streaming_on_netflix)
  end

  it "has link to director index" do
    carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)

    visit "/directors/#{carpenter.id}/films"

    expect(page).to have_link('Director Index')
  end

  it "click director index link and go to director index page" do
    carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)

    visit "/directors/#{carpenter.id}/films"

    click_link('Director Index')

    expect(current_path).to eq("/directors")
  end

  it "has link to films index" do
    carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
    mars = carpenter.films.create!(name: 'Ghosts of Mars', runtime: 98, streaming_on_netflix: false)

    visit "/directors/#{carpenter.id}/films"

    expect(page).to have_link('Film Index')
  end

  it "click film index link and go to film index page" do
    carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
    mars = carpenter.films.create!(name: 'Ghosts of Mars', runtime: 98, streaming_on_netflix: false)
    
    visit "/directors/#{carpenter.id}/films"

    click_link('Film Index')

    expect(current_path).to eq("/films")
  end

  it 'has a link to create a new film for director' do
    carpenter = Director.create!(name: 'John Carpenter', academy_awards: 0, deceased: false)
    halloween = carpenter.films.create!(name: 'Halloween', runtime: 91, streaming_on_netflix: false)
    vamps = carpenter.films.create!(name: 'Vampires', runtime: 103, streaming_on_netflix: true)
    mars = carpenter.films.create!(name: 'Ghosts of Mars', runtime: 98, streaming_on_netflix: false)

    visit "/directors/#{carpenter.id}/films"

    expect(page).to have_link("Add Film")
  end

  it 'has a link to sort films alphabetically' do
    carpenter = Director.create!(name: 'John Carpenter', academy_awards: 0, deceased: false)
    halloween = carpenter.films.create!(name: 'Halloween', runtime: 91, streaming_on_netflix: false)
    vamps = carpenter.films.create!(name: 'Vampires', runtime: 103, streaming_on_netflix: true)
    mars = carpenter.films.create!(name: 'Ghosts of Mars', runtime: 98, streaming_on_netflix: false)

    visit "/directors/#{carpenter.id}/films"
  
    expect(page).to have_link("Sort Films Alphabetically")
  end

  it 'click link to sort films alphabetically' do
    carpenter = Director.create!(name: 'John Carpenter', academy_awards: 0, deceased: false)
    halloween = carpenter.films.create!(name: 'Halloween', runtime: 91, streaming_on_netflix: false)
    vamps = carpenter.films.create!(name: 'Vampires', runtime: 103, streaming_on_netflix: true)
    mars = carpenter.films.create!(name: 'Ghosts of Mars', runtime: 98, streaming_on_netflix: false)

    visit "/directors/#{carpenter.id}/films"
  
    click_link "Sort Films Alphabetically"

    within "#film0" do
      expect(page).to have_content('Ghosts of Mars')
    end

    within "#film1" do
      expect(page).to have_content('Halloween')
    end

    within "#film2" do
      expect(page).to have_content('Vampires')
    end
  end

  it 'has link to edit each film' do
    kubrick = Director.create!(name: 'Stanley Kubrick', academy_awards: 13, deceased: true)
    shining = kubrick.films.create!(name: 'The Shining', runtime: 146, streaming_on_netflix: true)
    fmj = kubrick.films.create!(name: 'Full Metal Jacket', runtime: 116, streaming_on_netflix: true)
    orange = kubrick.films.create!(name: 'A Clockwork Orange', runtime: 136, streaming_on_netflix: false)

    visit "/directors/#{kubrick.id}/films"

    within "#film0" do
      expect(page).to have_link("Edit")

      click_link "Edit"

      expect(current_path).to eq("/films/#{shining.id}/edit")
    end

    visit "/directors/#{kubrick.id}/films"

    within "#film1" do
      expect(page).to have_link("Edit")

      click_link "Edit"

      expect(current_path).to eq("/films/#{fmj.id}/edit")
    end

    visit "/directors/#{kubrick.id}/films"

    within "#film2" do
      expect(page).to have_link("Edit")

      click_link "Edit"

      expect(current_path).to eq("/films/#{orange.id}/edit")
    end
  end

  it 'has a form to return films over a given thereshold' do
    kubrick = Director.create!(name: 'Stanley Kubrick', academy_awards: 13, deceased: true)
    shining = kubrick.films.create!(name: 'The Shining', runtime: 146, streaming_on_netflix: true)
    fmj = kubrick.films.create!(name: 'Full Metal Jacket', runtime: 116, streaming_on_netflix: true)
    orange = kubrick.films.create!(name: 'A Clockwork Orange', runtime: 136, streaming_on_netflix: false)

    visit "/directors/#{kubrick.id}/films"

    expect(page).to have_content("Full Metal Jacket")

    visit "/directors/#{kubrick.id}/films" 
  
    fill_in('film_runtimes_greater_than', with: '120')

    click_button('Search')

    expect(current_path).to eq("/directors/#{kubrick.id}/films")
    expect(page).to have_content("The Shining")
    expect(page).to_not have_content("Full Metal Jacket")
  end
end