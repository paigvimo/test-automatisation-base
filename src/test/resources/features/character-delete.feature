@REQ_PIVIDAL-0001 @karate @AutomationTest @CharacterDelete
Feature: Character Api Delete

  Background:
    * configure ssl = true
    * def apiUrl = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/pividal/api/characters'

  @id:1 @DeleteExistingCharacter
  Scenario: PIVIDAL-0001-CA1-Delete existing character
    * def characterId = 11
    Given url apiUrl + '/' + characterId
    When method delete
    Then status 204
    * print response

  @id:2 @DeleteUnexistingCharacter
  Scenario: PIVIDAL-0001-CA2-Delete unexisting character
    * def characterId = 999
    Given url apiUrl + '/' + characterId
    When method delete
    Then status 404
    * print response
    * match response.error == 'Character not found'
