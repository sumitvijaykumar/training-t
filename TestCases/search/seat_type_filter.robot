*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource     ${EXECDIR}/Keywords/kw_customer.robot
Resource    ../Keywords/common.robot
*** Test Cases *** 

TC_001_Verify if a user is able to filter bus according to their seat preference
    
    Open Make My Trip As
    Search Buses     Coimbatore    Trivandrum  
    Select Filter     Seat type     Sleeper
    Get All Bus Id    Seat type     Sleeper