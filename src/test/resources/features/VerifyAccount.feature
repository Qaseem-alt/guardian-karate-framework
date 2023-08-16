@Regression
Feature: verify account

Background:
Given url "https://tek-insurance-api.azurewebsites.net"
* def result = callonce read('GenerateToken.feature')
And print result
* def validToken = result.response.token
# * = waild card it can be anything (when, and , Then) 
# def you can define a variable Exp: below existingId 
# you can call a feauter file from another Feature file and by using def you can define it to a verable

Scenario: Verify an account that is exist

Given path "/api/accounts/get-account"
* def existingId = 10755
And param primaryPersonId = existingId
#Headre have to add to request.
And header Authorization = "Bearer " + validToken
When method get
Then status 200
And print response
And assert response.primaryPerson.id == existingId

Scenario: Verify get-account with id not exist

Given path "/api/accounts/get-account"
* def notExicetId = 10755123
And param primaryPersonId = notExicetId
#Headre have to add to request.
And header Authorization = "Bearer " + validToken
When method get
Then status 404
And print response
And assert response.errorMessage == "Account with id " + notExicetId + " not found"







