# Accopunt Should be exist to delete. 200 status code 
#Amke sure account that is not ecxist to get 404 Status
@Regression
Feature: Delet Account functionality 

Background: Test Setup and Create new Account 
* def createAccount = callonce read('CreateAccount.feature')
* def validToken = createAccount.validToken
* def createdAccountId = createAccount.response.id
And print createAccount
Given url "https://tek-insurance-api.azurewebsites.net"


Scenario: Successfully delete account
Given path "/api/accounts/delete-account"
And param primaryPersonId = createdAccountId
And header Authorization = "Bearer " + validToken
When method delete
Then status 200
Given url "https://tek-insurance-api.azurewebsites.net"
Given assert response == "Account Successfully deleted"
Given path "/api/accounts/delete-account"
And param primaryPersonId = createdAccountId
And header Authorization = "Bearer " + validToken
When method delete
Then status 404
And print response
And assert response.errorMessage == "Account with id " + createdAccountId + " not exist"
