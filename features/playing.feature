Feature: Playing
	In order to play Rock Paper Scissors
	As a player
	I need to get two players

	Scenario: A player can register
		Given I am on the homepage
		When I press "Single Player"
		And I enter my name
		When I press "Play!"
		Then I should be ready to play

	Scenario: A player is playing single player round
		Given I've registered to play
		When I choose Paper
		Then I should see "RESULTS"
		When I press "Play again!"
		And I choose Paper
		Then I should see "RESULTS"

	Scenario: A player is trying to play a two players round
		Given I've registered to play with two players
		Then I should see "Let's wait a moment"
		Then Another player registers for playing
		When I choose Paper
		Then I should see "Let's wait a moment"