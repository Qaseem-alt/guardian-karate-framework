@Regression
Feature: 

  Background: 
    * def result = callonce read('GenerateToken.feature')
    * def validToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Create valid account
    And path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + validToken
    # calling java class in feature file. this utility will create object from java class
    * def generateDataObject = Java.type('api.utility.data.GenerateData')
    * def autoEmail = generateDataObject.getEmail()
    And request
      """
       {"email": "#(autoEmail)", 
       "firstName": "Qaseem", 
       "lastName": "JAaa", 
       "title": "Mr.", 
       "gender": "MALE", 
       "maritalStatus": "SINGLE", 
       "employmentStatus": "Student", 
       "dateOfBirth": "2000-08-09", 
       "new": true,}
      """
    When method post
    Then status 201
    And print response
    And print result
    And assert response.email == autoEmail