*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource     ${EXECDIR}/Keywords/kw_customer.robot
Resource    ../Keywords/common.robot

*** Test Cases ***
001
   [Documentation]  Verify that only one filter can be selected from: "AC" and "Non AC"
   ...  Author: Akarsh
   ...  Steps:
   ...  1. 
   ...  2.
   ...  
   ...  Expected Result: 
   ...

   [Tags]      selectOne

   Search Buses    Coimbatore    Trivandrum    
   Select filter  AC  Non AC
   Get all bus   Non A/C
   Verify filter

002
   [Documentation]  Verify that only one filter can be selected from: "AC" and "Non AC"
   ...  Author: Akarsh
   ...  Steps:
   ...  1. 
   ...  2.
   ...  
   ...  Expected Result: 

   