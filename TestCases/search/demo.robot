*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource     ${EXECDIR}/Keywords/kw_customer.robot
Variables   ${EXECDIR}/Variables/search_data.yaml


*** Test Cases ***
TC_001
   [Documentation]  Verify that only one filter can be selected from: "AC" and "Non AC"
   ...  Author: Akarsh
   ...  Steps:
   ...  1. 
   ...  2.
   ...  
   ...  Expected Result: 
   ...

   [Tags]      selectOne
   Open Make My Trip As
   Search Buses   



   