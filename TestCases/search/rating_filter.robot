*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource     ${EXECDIR}/Keywords/kw_customer.robot
Resource    ../Keywords/common.robot
Library    String
*** Test Cases ***

TC_001
    [Documentation]     Verify if a user is able to filter bus according to their ratings
    ...    Author: Ashly
    ...    steps
    ...    1. open the browser and go to make my trip website using the url
    ...    2. click close button of the popup
    ...    3. click on bus icon
    ...    4. click the from and to input box and search places 'Coimbatore' and 'Trivandrum'
    ...    5. click on traveldate and select the date
    ...    6. click the search button
    ...    7. click the view more option to see all buses
    ...    8. Get the number of buses and its ratings as a sorted array
    ...    9. Click on top rated to see the top rated bus
    ...    10. verify the last element of sorted array and the top rated are equal
    ...    Expected: The last element of sorted array and the top rated are equal

    Open Make My Trip As
    Search Buses    Coimbatore    Trivandrum
    ${last_element}    Get All Bus Rating
    ${top_rating}    Get Top Rated Bus
    Check If Ratings Are Equal    ${last_element}    ${top_rating}

#verify that all buses are displayed when user unselects top rated icon again.

TC-002
    [Documentation]     Verify  all buses are displayed when user unselects top rated icon again
    ...    Author: Ashly
    ...    steps
    ...    1. open the browser and go to make my trip website using the url
    ...    2. click close button of the popup
    ...    3. click on bus icon
    ...    4. click the from and to input box and search places 'Coimbatore' and 'Trivandrum'
    ...    5. click on traveldate and select the date
    ...    6. click the search button
    ...    7. click the view more option to see all buses
    ...    8. Get the number of buses and its ratings as a sorted array
    ...    9. Click on top rated to see the top rated bus
    ...    10. Unselect top rated 
    ...    11. Get the number of buses and its ratings as a sorted array
    ...    12. verify the number of buses before selecting toprated and after unselecting toprated are the same
    ...    Expected: The number of buses before selecting toprated and after unselecting toprated are the same
    
    Open Make My Trip As
    Search Buses    Coimbatore    Trivandrum
    ${numberOfBuses}    Get All Bus Rating
    ${numberOfBusesafter}    Get All Bus Rating after unselect
    Verify number of buses are equal    ${numberOfBuses}    ${numberOfBusesafter} 