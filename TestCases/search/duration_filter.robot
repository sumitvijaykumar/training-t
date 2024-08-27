*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource     ${EXECDIR}/Keywords/kw_customer.robot
Resource    ../Keywords/common.robot
*** Test Cases ***
TC-001
    [Documentation]     Verify user is able to get bus list according to the ascending duration
    ...    Author: Sneha Mathai
    ...    steps
    ...    1. Open the browser and navigate to make my trip website 
    ...    2. click on the close button of the popup window
    ...    3. Click on bus icon
    ...    4. Click the from and to input box and input places 'Coimbatore' and 'Trivandrum'
    ...    5. Click on travel date and select 
    ...    6. Click on the the search button
    ...    7. Click the view more option to see all buses ksrtc buses
    ...    8. Click on the fastest button Up-arrow 
    ...    9. Get the durations of all buses
    ...    10.Verify the duration is in descending order for both KSRTC and private buses.
    ...    11.Click on the fastest button again down-arrow
    ...    12.Get the duration of all buses
    ...    13.Verify the duration is in descending order for both KSRTC and private buses.
    ...    Expected result :
    ...    Upon clicking the on the fastest up arrow; buses with the shortest duration appear in order.
       
   [Tags]      SelectOne 


    Open Make My Trip As
    Search Buses  ${${SUITE_NAME}.${TEST_NAME}.FROM}
    ${ascendingDurations}    select fastest and get bus duration       
    Validate Durations Sorted    ${ascendingDurations}   ascending

TC_002 
    [Documentation]     Verify user is able to get bus list according to descending duration
    ...    Author: Sneha Mathai
    ...    steps
    ...    1.  Repeat steps 1 to 7 in TC_001
    ...    2.Click on the fastest button again down-arrow
    ...    3. Verify the duration is in descending order for both KSRTC and private buses.
    ...    Expected result :
    ...    1.Upon clicking the fastest down arrow; buses with the longest duration appear in order.

    [Tags]      SelectOne 
    Open Make My Trip As
    Search Buses  
    ${descendingDurations}    select fastest and get bus duration    
    Validate Durations Sorted   ${descendingDurations}  descending  

    
TC-003
    [Documentation]     Verify Relevance Filter Does Not Toggle Upward Arrow on Second Click
    ...    Author: Sneha Mathai
    ...    steps
    ...    1.  Open the browser and navigate to make my trip website 
    ...    2. click on the close button of the popup window
    ...    3. Click on bus icon
    ...    4. Click the from and to input box and input places 'Coimbatore' and 'Trivandrum'
    ...    5. Click on travel date and select 
    ...    6. Click on the search button
    ...    7. Click the view more option to see all buses ksrtc buses
    ...    8. Click on the Relevance button 
    ...    9. Verify Relevance Filter Does Not Toggle Upward Arrow on Second Click
 
    ...    Expected result :
    ...    1. Clicking the relevance button does not toggle the arrow to the upward direction upon the second click.

   [Tags]      SelectOne

   Open Make My Trip As 
   Search Buses    
   Select Relevance 
   verify relevance is not toggled  
#Verify that relevance sort has only one order of display