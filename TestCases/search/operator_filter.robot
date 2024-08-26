*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource     ${EXECDIR}/Keywords/kw_customer.robot
Resource    ../Keywords/common.robot
*** Test Cases ***
TC_001
   [Documentation]  Description here
   ...  Author: Archana
   ...  Steps:
   ...  1. 
   ...  2.
   ...  
   ...  Expected Result: 
   ...

   [Tags]      selectMany
    Open Make My Trip As
    Search Buses    Coimbatore    Trivandrum
    Select Filter    Travel Operators     A1 Travels
    Get filtered Bus Names    Travel Operators     A1 Travels
    Clear Travel operator Filter     Travel Operators
