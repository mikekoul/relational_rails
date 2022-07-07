require 'rails_helper'

RSpec.describe "directors index page", type: :feature do
  it "can see names of all directors" do
    director_1 = Director.create!(name: "Stanley Kubrick")
    director_2 = Director.create!(name: "John Carpenter")

    visit "/directors"

    expect(page).to have_content(director_1.name)
    expect(page).to have_content(director_2.name)
  end
end