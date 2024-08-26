*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource     ${EXECDIR}/Keywords/kw_customer.robot
Resource    ../Keywords/common.robot
*** Test Cases ***

TC_001_Verify the departure date of buses should be same as entered
    Open Make My Trip As
    Search Buses    Coimbatore    Trivandrum
    ${allBusDate}    ${numberOfBuses}    Get All Bus Date
    ${inputDate}    Get Input Date
    Validating Data    ${allBusDate}    ${numberOfBuses}    ${inputDate}

