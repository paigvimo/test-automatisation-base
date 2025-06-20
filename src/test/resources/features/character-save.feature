@REQ_PIVIDAL-0001 @karate @AutomationTest @CharacterSave
Feature: Character Api Save

  Background:
    * configure ssl = true
    * header Content-Type = 'application/json'
    * def apiUrl = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/pividal/api/characters'

  @id:1 @SaveNewCharacter
  Scenario Outline: PIVIDAL-0001-CA1-Save new characters
    Given url apiUrl
    * def body = read('data/character-body.json')
    * set body.name = '<name>'
    * set body.alterego = '<alterego>'
    * set body.description = '<description>'
    * set body.powers = <powers>
    And request body
    When method post
    Then status 201
    * print response
    * match response.name == '<name>'
    * match response.alterego == '<alterego>'
    * match response.description == '<description>'
    Examples:
      | name         | alterego | description         | powers                                 |
      | Black Widow  | Natasha Romanoff    | Elite spy and martial artist  | ["Martial Arts", "Agility"]         |

  @id:2 @SaveCharacterWithDuplicatedName
  Scenario Outline: PIVIDAL-0001-CA2-Save characters with duplicated name
    Given url apiUrl
    * def body = read('data/character-body.json')
    * set body.name = '<name>'
    * set body.alterego = '<alterego>'
    * set body.description = '<description>'
    * set body.powers = <powers>
    And request body
    When method post
    Then status 400
    * print response
    * match response.error == 'Character name already exists'
    Examples:
      | name         | alterego | description         | powers                                 |
      | Iron Man  | Tony Stark    | Genius billionaire in a high-tech armored suit  | ["Powered Armor", "Flight"]         |

  @id:3 @SaveCharacterWithInvalidData
  Scenario: PIVIDAL-0001-CA3-Save characters with invalid data
    Given url apiUrl
    * def body = read('data/character-body.json')
    And request body
    When method post
    Then status 400
    * print response
    * match response.name == 'Name is required'
    * match response.alterego == 'Alterego is required'
    * match response.description == 'Description is required'
    * match response.powers == 'Powers are required'