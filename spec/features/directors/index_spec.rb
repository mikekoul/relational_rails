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
end