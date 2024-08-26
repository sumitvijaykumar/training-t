*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource     ${EXECDIR}/Keywords/kw_customer.robot
Resource    ../Keywords/common.robot
*** Test Cases ***
TC_001_Verify if a user is able to filter bus according to price
    Open Make My Trip As
    Search Buses    Coimbatore    Trivandrum     
    Select Cheapest
    Get All Bus Price and verify

#Verify that only one category of sorting can be selected.
# if another sirt is selected, previous sort is automatically unselected. 