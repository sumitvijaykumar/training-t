*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource     ${EXECDIR}/Keywords/kw_customer.robot
Resource    ../Keywords/common.robot
*** Test Cases ***
TC_001_Verify if a user is able to filter bus according to their drop time
    Open Make My Trip As
    Search Buses    ${from}    ${to}    ${date}
    Select Filter    Drop time    6 AM to 11 AM
    Filter time-00

# Verify that user is able to select multiple time slot in drop time filter.
