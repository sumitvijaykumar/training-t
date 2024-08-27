*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource     ${EXECDIR}/Keywords/kw_customer.robot
Resource    ../../Keywords/common.robot
Resource    ../../Keywords/kw_customer.robot
Variables    ../../Variables/search_data.yaml
*** Test Cases ***

TC_001
    [Documentation]    Verify the departure date of buses should be same as entered
    ...    Author: Albin
    ...    Steps
    ...    1: Open the browser and go to the make my trip page using the url
    ...    2: Click on the close icon on the pop screen window
    ...    3: Click on the buses icon
    ...    4: Click on the from input box and give input coimbatre
    ...    5: Click on the to input box and give input trivandram
    ...    6: click on travel date and click on the date shows inthe calender
    ...    7: Click on search button
    ...    8: Click on view buses in the ksrtc card
    ...    9: Verify the date we gave is same as the dates in the bus card  
    Open Make My Trip As
    Search Buses
    ${allBusDate}    ${numberOfBuses}    Get All Bus Date
    ${inputDate}    Get Input Date
    Validating Data    ${allBusDate}    ${numberOfBuses}    ${inputDate}

TC_002
    [Documentation]    Verify the departure date i.e, (click today in departure date section) of buses should be same as today
    ...    Author: Albin
    ...    Steps
    ...    1: Open the browser and go to the make my trip page using the url
    ...    2: Click on the close icon on the pop screen window
    ...    3: Click on the buses icon
    ...    4: Click on the from input box and give input coimbatre
    ...    5: Click on the to input box and give input trivandram
    ...    6: click on travel date and click on the date shows inthe calender
    ...    7: Click on search button
    ...    8: Click on today in daparture date
    ...    8: Click on view buses in the ksrtc card
    ...    9: Verify the date we gave(i.e,) is same as the dates in the bus card  
    Open Make My Trip As
    Search Buses
    Click todays date
    ${allBusDate}    ${numberOfBuses}    Get All Bus Date
    ${inputDate}    Get Input Date
    Validating Data    ${allBusDate}    ${numberOfBuses}    ${inputDate}