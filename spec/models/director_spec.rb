require 'rails_helper'

RSpec.describe Director, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :academy_awards }
    it { should allow_value(true).for(:deceased) }
    it { should allow_value(false).for(:deceased) }
  end

  describe 'relationships' do
    it { should have_many :films }
  end

  describe 'methods' do
    it 'returns directors sorted by which was created first to last' do
      kubrick = Director.create!(name: "Stanley Kubrick", academy_awards: 13, deceased: true)
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
      jackson = Director.create!(name: "Peter Jackson", academy_awards: 9, deceased: false)
      toro = Director.create!(name: "Guillermo del Toro", academy_awards: 6, deceased: false)
      directors = Director.all

      expect(directors.sort_by_datetime_created.first).to eq(toro)
      expect(directors.sort_by_datetime_created.last).to eq(kubrick)
    end

    it 'returns number of films belonging to director' do
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
      halloween = carpenter.films.create!(name: 'Halloween', runtime: 91, streaming_on_netflix: false)
      vamps = carpenter.films.create!(name: 'Vampires', runtime: 103, streaming_on_netflix: true)
      mars = carpenter.films.create!(name: 'Ghosts of Mars', runtime: 98, streaming_on_netflix: false)

      expect(carpenter.film_count).to eq(3)
    end

    it 'return films with runtime greater than x' do
      carpenter = Director.create!(name: "John Carpenter", academy_awards: 0, deceased: false)
      halloween = carpenter.films.create!(name: 'Halloween', runtime: 91, streaming_on_netflix: false)
      vamps = carpenter.films.create!(name: 'Vampires', runtime: 103, streaming_on_netflix: true)
      mars = carpenter.films.create!(name: 'Ghosts of Mars', runtime: 98, streaming_on_netflix: false)
      input_runtime = 95

      expect(carpenter.film_runtimes_greater_than(input_runtime)).to eq([vamps, mars])
    end
  end
end
