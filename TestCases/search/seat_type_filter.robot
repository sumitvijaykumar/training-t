*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource     ${EXECDIR}/Keywords/kw_customer.robot
Variables    ${EXECDIR}/Variables/search_data.yaml

*** Test Cases *** 

TC_001
    [Documentation]    Verify if a user is able to filter bus according to their seat preference  
    ...    Author : Gayathri M
    ...    Step 1 : Enter url of make my trip, enlarge the window
    ...    Step 2 : Close the window coming up, select bus icon 
    ...    Step 3 : Select from, to city,  date and search buses
    ...    Step 4 : Select seat type and verify it
    ...    Expected result : Only the buses with preferred seat type should appear.

    # [Tags]    selectOne
    Open Make My Trip As
    Search Buses     ${${SUITE_NAME}.${TEST_NAME}.FROM}    ${${SUITE_NAME}.${TEST_NAME}.TO}  
    Select Filter     Seat type     Sleeper
    ${numberOfBuses}    Get All Bus Id         
    Verify Seat Type    ${numberOfBuses}    Seat type    Sleeper

TC_002
    [Documentation]    Verify that only one filter can be selected from : 'Sleeper'  and 'Seater'
    ...    Author : Gayathri M
    ...    Step 1 : Enter url of make my trip, enlarge the window
    ...    Step 2 : Close the window coming up, select bus icon 
    ...    Step 3 : Select from, to city,  date and search buses
    ...    Step 4 : Select one seat type and verify it
    ...    Step 5 : Select other seat type 
    ...    Expected result : The previous selected filter must be automatically disabled while selecting other filter.
    
    [Tags]    selectOne
    Open Make My Trip As
    Search Buses     ${${SUITE_NAME}.${TEST_NAME}.FROM}    ${${SUITE_NAME}.${TEST_NAME}.TO}  
    Select Filter     Seat type     Sleeper
    ${numberOfBuses}    Get All Bus Id         
    Select Other Filter    Seat type    Sleeper    Seater     