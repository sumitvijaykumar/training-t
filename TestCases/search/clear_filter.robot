*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource     ${EXECDIR}/Keywords/kw_customer.robot
Resource    ../Keywords/common.robot
*** Test Cases ***

TC_001 Verify that if pick up point filter is selected only one "Clear" button turns blue and all other buttons remain grey
    [Documentation]  Description here
   ...  Author: Arsha
   ...  Steps:
   ...  1.Enter the URL :  http://www.makemytrip.com/
   ...  2.Enter the source and destination
   ...  3. Click on the pick up time 6AM to 11AM
   ...  4.Verify the "CLEAR ALL" button of the section "pick up time" is only turned blue and others remains grey
   ...  
   ...  Expected Result: The "CLEAR ALL" button of the section "pick up time" should only turned blue and others remains grey
   ...

   [Tags]      selectMany   selectOne
    
    Open Make My Trip As
    Search Buses
    Select Filter  the filter  Pick up time (6 AM to 11 AM) and verify

#  Verify that if pick up point filter is selected only one "Clear" button turns blue and all other buttons remain gray