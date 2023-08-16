@Regression
Feature:

Background:
Given url "https://tek-insurance-api.azurewebsites.net"
* def tokenFeatureResult = callonce read('GenerateToken.feature')
And print tokenFeatureResult
* def validToken = tokenFeatureResult.response.token

Scenario:
And path "/api/plans/get-all-plan-code"
And header Authorization = "Bearer " + validToken
When method get
Then status 200
And print response
And assert response[0].planExpired == false
And assert response[1].planExpired == false
And assert response[2].planExpired == false
And assert response[3].planExpired == false
#false is not in "" becase its a boolen not string

