require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit games_url
  #
  #   assert_selector "h1", text: "Game"
  # end

  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "Fill in the form with a random word and get a message that the word is not in the grid" do
    visit new_url
    fill_in "word", with: "zzzz"
    click_on "Play"
    # assert_selector "p", text: "Sorry but #{params[:word]} can't be built out of #{params[:tags_list]}"
    take_screenshot
  end

  test "fill the form with a one-letter consonant, get a message it's not a valid  word" do
    visit new_url
    consonant = ''
    all('li').each { |li| consonant = li.text if li.text.match?(/[^AEIOU]/) }
    fill_in "word", with: "#{consonant}"
    click_on "Play"
    take_screenshot
  end
end


