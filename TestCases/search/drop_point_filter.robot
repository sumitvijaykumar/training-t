*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource     ${EXECDIR}/Keywords/kw_customer.robot
Resource    ../Keywords/common.robot
*** Test Cases ***

TC_001_Verify if a user is able to filter bus according to their drop point
    Open Make My Trip As
    Search Buses    Coimbatore    Trivandrum 
    Select drop point    Drop point     Pattam   
    Verify drop point    Pattam  

# 002
# Verify that user can select multiple drop points