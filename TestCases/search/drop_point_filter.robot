*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource     ${EXECDIR}/Keywords/kw_customer.robot
Resource    ../Keywords/common.robot
Variables    ${EXECDIR}/Variables/search_data.yaml
*** Test Cases ***

TC_001
    [Documentation] 
    ...  Verify if a user is able to filter bus according to their drop point
    ...  Author: Gokul
    ...  Steps:
    ...  open make my trip
    ...  go to busses page
    ...  search busess from and to cities
    ...  select the drop point
    ...  verify results shown has the selected drop point

    Open Make My Trip As
    Search Buses   
    Select drop point    Drop point     ${${SUITE_NAME}.${TEST_NAME}.DROP_POINT}
    Verify drop point     ${${SUITE_NAME}.${TEST_NAME}.DROP_POINT}

# 002
# Verify that user can select multiple drop points
TC_002
    [Documentation]
    ...    Verify if user is able to select multiple drop points
    ...    Author:Gokul
    ...    steps:
    ...    open make my trip
    ...    go to busses page
    ...    search buses from and to cities
    ...    select two or more drop points
    ...    check user can select two or more drop points
    
    Open Make My Trip As
    Search Buses  
    Select drop point    Drop point    ${${SUITE_NAME}.${TEST_NAME}.DROP_POINT1}
    Select drop point    Drop point     ${${SUITE_NAME}.${TEST_NAME}.DROP_POINT2} 
    verify multiple drop points selected
    
    
    