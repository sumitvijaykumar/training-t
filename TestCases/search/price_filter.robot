*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource    ${EXECDIR}/Keywords/kw_customer.robot
Resource    ../Keywords/common.robot
Variables    ../../Variables/search_data.yaml

*** Test Cases ***

TC_001
   [Documentation]  Verify if a user is able to filter bus according to price
   ...  Author: Devika
   ...  Steps:
   ...  1. Open the makemytrip page in chrome browser
   ...  2.Close the pop up
   ...  3.Click on bus icon
   ...  4.Click on from input box to enter "from" place
   ...  5.Enter the  place
   ...  6.click on to input box to enter "to" place
   ...  7.Enter the destination place 
   ...  8.Click on travel date
   ...  9.Click on desired date
   ...  10.click on search button
   ...  11.Click on the element cheapest
   ...  12.Get all prices include KSRTC and private buses and verify it is in sorted order or not
   ...  
   ...  Expected Result:
   ...  1.User should be able to access the MakeMyTrip page
   ...  2.User should be able to close popup
   ...  3.User should enter the homepage and click on Bus Icon
   ...  4.User should be able to click on  "From"
   ...  5.User should be able to enter place and select from autosuggest
   ...  6.4.User should be able to click on  "To"
   ...  7.User should be able to enter place and select from autosuggest
   ...  8.User should be able to click on travel date
   ...  9.User should be able to click on specified date
   ...  10.User should be able to click on Search button and redirect to Next page
   ...  11.User should be able to click on "Cheapest" 
   ...  12.Get output as buses are sorted correctly

   [Tags]      selectOne
    Open Make My Trip As
    Search Buses        
    Select Cheapest
    Get All Bus Price and verify
TC_002
   [Documentation]  Verify that only one category of sorting can be selected once
   ...  Author: Devika
   ...  Steps:
   ...  1. Open the makemytrip page in chrome browser
   ...  2.Close the pop up
   ...  3.Click on bus icon
   ...  4.Click on from input box to enter "from" place
   ...  5.Enter the  place
   ...  6.click on to input box to enter "to" place
   ...  7.Enter the destination place 
   ...  8.Click on travel date
   ...  9.Click on desired date
   ...  10.click on search button
   ...  11.Click on the "Cheapest" button and verify it turns blue
   ...  12.Click on another sort button "Fastest"
   ...  13.Verify that the "Cheapest" button is no longer active 
   ...  
   ...  Expected Result:
   ...  1.User should be able to access the MakeMyTrip page
   ...  2.User should be able to close popup
   ...  3.User should enter the homepage and click on Bus Icon
   ...  4.User should be able to click on  "From"
   ...  5.User should be able to enter place and select from autosuggest
   ...  6.4.User should be able to click on  "To"
   ...  7.User should be able to enter place and select from autosuggest
   ...  8.User should be able to click on travel date
   ...  9.User should be able to click on specified date
   ...  10.User should be able to click on Search button and redirect to Next page
   ...  11.User should be able to click on "Cheapest" and Cheapest button should be active
   ...  12.Fastest button should be active 
   ...  13.Cheapest button should not be active
   ...  
   ...  
   [Tags]      selectOne     
    Open Make My Trip As
    Search Buses    
    Click Cheapest Button And Verify
    Click Another Sort Button And Verify


#Verify that only one category of sorting can be selected.
# if another sort is selected, previous sort is automatically unselected. 