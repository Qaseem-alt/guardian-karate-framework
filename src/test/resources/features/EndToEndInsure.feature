Feature: 

  Background: 
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def createdAccount = callonce read('CreateAccount.feature')
    * def primaryAccountId = createdAccount.response.id
    * def validToken = createdAccount.result.response.token

  Scenario: End To End Test for account creation
    Given url "https://tek-insurance-api.azurewebsites.net"
    When path "api/accounts/add-account-phone"
    And param primaryPersonId = primaryAccountId
    And header Authorization = "Bearer " + validToken
    * def dataGenerator = Java.type('api.utility.data.GenerateData')
    * def phoneNumber = dataGenerator.getPhoneNumber()
    And request
      """
      {
        "phoneNumber": "#(phoneNumber)",
        "phoneExtension": "2020",
        "phoneTime": "any",
        "phoneType": "Mobile"
      }
      """
    And method post
    Then status 201
    Given url "https://tek-insurance-api.azurewebsites.net"
    When path "/api/accounts/add-account-address"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = primaryAccountId
    And request
      """
      {
        "addressType": "APT",
        "addressLine1": "10433 se kent-kangley",
        "city": "Kent",
        "state": "WA",
        "postalCode": "APT422",
        "countryCode": "+1",
        "current": true
      }
      """
    And method post
    Then status 201
    Given url "https://tek-insurance-api.azurewebsites.net"
    When path "/api/accounts/add-account-car"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = primaryAccountId
    And request
      """
      {
      "make": "Mazda",
      "model": "v6",
      "year": "2023",
      "licensePlate": "cet123te"
      }
      """
    And method post
    Then status 201
    Given url "https://tek-insurance-api.azurewebsites.net"
    When path "/api/accounts/delete-account"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = primaryAccountId
    And method delete
    Then status 200
    Given assert response == "Account Successfully deleted"
