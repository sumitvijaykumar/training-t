*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource     ${EXECDIR}/Keywords/kw_customer.robot
Variables     ${EXECDIR}/Variables/search_data.yaml
Library    String
*** Test Cases ***
TC_001
   [Documentation]  Verify that user can select only AC filter  and is not able to select both AC and NOn AC
   ...  Author: Akarsh
   ...  Steps:
   ...  1.Open browser 
   ...  2.enter url : www.makemytrip.com
   ...  3.close the pop up
   ...  4.click on bus icon
   ...  5.click on from input box
   ...  6.enter place
   ...  7.click desired place from autosuggestion
   ...  8.click on to input box
   ...  9.enter desired place 
   ...  10.click desired place from autosuggestion
   ...  11.click on travel date
   ...  12.click on desired date
   ...  13.click on search button
   ...  14.click on AC button 
   ...  14.Verify user is not able to select both  AC and Non AC filter
   ...  15.Verify user is able to see only ac bus   
   ...  Expected Result: 
   ...

   [Tags]      selectOne
   Log     ${SUITE NAME}
   Open Make My Trip As 
   Search Buses     
   Select filter  AC  AC
   Get all bus   A/C
   Verify filter
TC_002
   [Documentation]  Verify that user can select only Non AC filter  and is not able to select both AC and NOn AC
   ...  Author: Akarsh
   ...  Steps:
   ...  1.Open browser 
   ...  2.enter url : www.makemytrip.com
   ...  3.close the pop up
   ...  4.click on bus icon
   ...  5.click on from input box
   ...  6.enter place
   ...  7.click desired place from autosuggestion
   ...  8.click on to input box
   ...  9.enter desired place 
   ...  10.click desired place from autosuggestion
   ...  11.click on travel date
   ...  12.click on desired date
   ...  13.click on search button
   ...  14.click on Non AC button 
   ...  14.Verify user is not able to select both  AC and Non AC filter
   ...  15.Verify user is able to see only ac bus   
   ...  Expected Result: 
   ...

   [Tags]      selectOne
   Log     ${SUITE NAME}
   Open Make My Trip As 
   Search Buses     
   Select filter  AC  Non AC
   Get all bus   Non A/C
   Verify filter



   