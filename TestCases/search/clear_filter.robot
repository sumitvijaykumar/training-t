*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource     ${EXECDIR}/Keywords/kw_customer.robot
Resource    ../Keywords/common.robot
*** Test Cases ***

TC_001
    [Documentation]  Description here
   ...  Author: Arsha
   ...  Steps:
   ...  1. 
   ...  2.
   ...  
   ...  Expected Result: 
   ...

   [Tags]      selectMany   selectOne
    
    Select Filter    AC    AC
    Select Filter    Seat type    Sleeper
    Select Filter    Seater/    Single
    Select Filter    Pick up point    Ettimadai
    Select Filter    Pick up time    6 AM to 11 AM
    Select Filter    Travel Operators    A1 Travels
    Select Filter    Drop point    Kazhakootam
    Select Filter    Drop time    6 AM to 11 AM
    Clear Filter           

#  Verify that if pick up point filter is selected only one "Clear" button turns blue and all other buttons remain gray