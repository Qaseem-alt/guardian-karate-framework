@Regression
Feature: 

  Background: 
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def createdAccount = callonce read('CreateAccount.feature')
    And print createdAccount
    * def validToken = createdAccount.validToken
    * def createdAccountId = createdAccount.response.id
  Scenario: Adding phone number
		When path "api/accounts/add-account-phone"
    And param primaryPersonId = createdAccountId
    And header Authorization = "Bearer " + validToken
    * def dataGenerator = Java.type('api.utility.data.GenerateData')
    * def phoneNumber = dataGenerator.getPhoneNumber()
    And request
      """
      {
        "phoneNumber": "#(phoneNumber)",
        "phoneExtension": "2021",
        "phoneTime": "Evenin",
        "phoneType": "Mobile"
      }
      """
    * url "https://tek-insurance-api.azurewebsites.net"
    And method post
    Then status 201
    And assert response.phoneNumber == phoneNumber
# to fix it watch Aug_8 video time 2:10 
