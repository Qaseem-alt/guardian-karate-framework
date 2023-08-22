@Regression
Feature: Updating an accout car 

Background: setup test

* def CreatedAccount = callonce read('CreateAccount.feature')
* def validToken = CreatedAccount.validToken
* def PerimeryPersonId = CreatedAccount.response.id


Scenario: Add a car to new account
Given url "https://tek-insurance-api.azurewebsites.net"
When path "/api/accounts/add-account-car"
And header Authorization = "Bearer " + validToken
And request 
"""
{
    "make": "2022",
    "model": "Mazda",
    "year": "2012",
    "licensePlate": "cbt1254"
}
"""   
When param primaryPersonId = PerimeryPersonId
And method post
Then status 201
And print response
And assert response.licensePlate == "cbt1254"
* def carId = response.id
# updating existed account car
When path "/api/accounts/update-account-car"
And param primaryPersonId = PerimeryPersonId
And header Authorization = "Bearer " + validToken
And request 
"""
{
    "id": "#(carId)",
    "make": "Toyota",
    "model": "SportLimeted",
    "year": "2020",
    "licensePlate": "cbt1212"
}
"""   
And method put
Then status 202
And print response
And assert response.make == "Toyota"
And assert response.licensePlate =="cbt1212"
