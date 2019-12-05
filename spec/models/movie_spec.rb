require 'rails_helper'

RSpec.describe Movie, type: :model do

  let (:movie_one) do 
    Movie.new(name: "Lakshya", director_name: "Rakesh Roshan", release_date: "2003-12-02", is_active: false)
  end

  let (:movie_two) do
    Movie.new(name: "The Irishman", director_name: "Martin Scorsese", release_date: "2019-12-02", is_active: true)
  end

  it "is valid with valid attributes" do
    expect(movie_one).to be_valid
  end

  it "is not valid without name" do
    expect(Movie.new(name: nil, director_name: "Rakesh Roshan", release_date: "2003-12-02", is_active: false)).to_not be_valid
  end

  it "is not valid without director name" do
    expect(Movie.new(name: "Lakshya", director_name: nil, release_date: "2003-12-02", is_active: false)).to_not be_valid
  end

  it "is not valid without release date" do
    expect(Movie.new(name: "Lakshya", director_name: "Rakesh Roshan", release_date: nil, is_active: false)).to_not be_valid
  end

  it "is not valid without is active" do
    expect(Movie.new(name: "Lakshya", director_name: "Rakesh Roshan", release_date: "2003-12-02", is_active: nil)).to_not be_valid
  end

end
