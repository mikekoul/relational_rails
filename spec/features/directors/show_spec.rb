require 'rails_helper'

RSpec.describe "Directors show page", type: :feature do
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
    expect(page).to_not have_content(carpenter.academy_awards)
  end

  it "display whether they are deceased or not" do
    kubrick = Director.create!(name: "Stanley Kubrick", academy_awards: 13, deceased: true)
    carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)

    visit "/directors/#{kubrick.id}"

    expect(page).to have_content(kubrick.deceased)
    expect(page).to_not have_content(carpenter.deceased)
  end


end