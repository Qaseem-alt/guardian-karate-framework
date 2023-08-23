Feature: Register new user

Background: setup tests and creat new account
Given url "https://tek-insurance-api.azurewebsites.net"
* def CreatedAccount = callonce read('CreateAccount.feature')
* def fullName = CreatedAccount.response.firstName + "_" + CreatedAccount.response.lastName
* def PerimeryPersonId = CreatedAccount.response.id
* def GenerateData = Java.type('api.utility.data.GenerateData')
* def Auto_userName = GenerateData.getUserName()


Scenario: Sign up and register new user
Given path "api/sign-up/register"
And request 
""" 
{
  "primaryPersonId": "#(PerimeryPersonId)",
  "fullname": "#(fullName)",
  "username": "#(Auto_userName)",
  "password": "tek_4321$",
  "authority": "CUSTOMER",
  "accountType": "CUSTOMER"
}
"""
When method post 
And print response
Then status 201
