@Smoke
Feature: Security Token Tests

  Background: setup test
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"

  Scenario: Generate valid token with vaild username and password
    #Prepare Request
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response

  Scenario Outline: Validate token with invalid username
    And request
      """
      {
      "username": "<username>",
      "password": "<password>"
      }
      """
    #When you add 3qutations """ at the begening and at the end you can use multple lines, see below
    When method post
    Then status 400
    And print response
    And assert response.errorMessage == "<errorMessage>"

    Examples: 
      | username   | password       | errorMessage         |
      | wrong      | tek_supervisor | User not found       |
      | supervisor | wrong          | Password Not Matched |
