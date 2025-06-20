@REQ_PIVIDAL-0001 @karate @AutomationTest @CharacterUpdate
Feature: Character Api Search

  Background:
    * configure ssl = true
    * header Content-Type = 'application/json'
    * def apiUrl = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/pividal/api/characters'

  @id:1 @UpdateExistingCharacter
  Scenario Outline: PIVIDAL-0001-CA1-Update existing character
    * def characterId = 4
    Given url apiUrl + '/' + characterId
    * def body = read('data/character-body.json')
    * set body.name = '<name>'
    * set body.alterego = '<alterego>'
    * set body.description = '<description>'
    * set body.powers = <powers>
    And request body
    When method put
    Then status 200
    * print response
    * match response.name == '<name>'
    * match response.alterego == '<alterego>'
    * match response.description == '<description>'
    Examples:
      | name         | alterego | description         | powers                                 |
      | Iron Man  | Tony Stark    | Genius billionaire in a high-tech armored suit - modify  | ["Powered Armor", "Flight"]         |

  @id:1 @UpdateUnexistingCharacter
  Scenario Outline: PIVIDAL-0001-CA1-Update unexisting character
    * def characterId = 9999
    Given url apiUrl + '/' + characterId
    * def body = read('data/character-body.json')
    * set body.name = '<name>'
    * set body.alterego = '<alterego>'
    * set body.description = '<description>'
    * set body.powers = <powers>
    And request body
    When method put
    Then status 404
    * print response
    * match response.error == 'Character not found'
    Examples:
      | name         | alterego | description         | powers                                 |
      | Fake Name  | Fake Alterego    | Fake description  | ["No power"]         |
