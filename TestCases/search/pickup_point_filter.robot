*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource     ${EXECDIR}/Keywords/kw_customer.robot
Resource    ../Keywords/common.robot
*** Test Cases ***

TC_001_Verify if a user is able to filter bus according to their pick-up point
    
    Open Make My Trip As
    Search Buses    Coimbatore    Trivandrum             
    Select Filter     Pick up point     Ettimadai
    Pickups point    Ettimadai

#