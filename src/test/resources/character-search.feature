@REQ_PIVIDAL-0001 @karate @AutomationTest @CharacterSearch
Feature: Character Api Search

  Background:
    * configure ssl = true
    * def apiUrl = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/pividal/api/characters'

  @id:1 @GetAllCharacters
  Scenario: PIVIDAL-0001-CA1-Search all characters
    Given url apiUrl
    When method get
    Then status 200
    * print response
    * match response == '#[]'

  @id:2 @ExistingCharacterSearchById
  Scenario: PIVIDAL-0001-CA2-Search a existing character given id
    * def characterId = 1
    Given url apiUrl + '/' + characterId
    When method get
    Then status 200
    * print response
    * match response.id == characterId


  @id:3 @UnexistingCharacterSearchById
  Scenario: PIVIDAL-0001-CA3-Search a unexisting character given id
    * def characterId = 9999
    Given url apiUrl + '/' + characterId
    When method get
    Then status 404
    * print response
    * match response.error == 'Character not found'
