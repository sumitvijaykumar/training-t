*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource     ${EXECDIR}/Keywords/kw_customer.robot
Resource    ../Keywords/common.robot
Resource    ../../Keywords/common.robot
Resource    ../../Keywords/kw_customer.robot
*** Test Cases ***
TC_001
    Open Make My Trip As
    Search Buses    
    Select Filter    Drop time    6 AM to 11 AM
    Verify Filter time    6 AM to 11 AM

# Verify that user is able to select multiple time slot in drop time filter.

TC_002
    [Documentation]
    ...    Author Ameensha U
    ...    Steps :
    ...    1. Open the browser to bus booking page
    ...    2. Select multiple time slots in drop time filter
    ...    3. Verify multiple time slots are selected
    ...    Expected Result:
    ...    1.Make My Trip should be open
    ...    2.Multiple filter time are selected
    ...    3.Verified multiple filters are selected
    [Tags]    SelectMany
    Open Make My Trip As
    Search Buses
    Verify multiple time slot