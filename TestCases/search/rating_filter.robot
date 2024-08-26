*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource     ${EXECDIR}/Keywords/kw_customer.robot
Resource    ../Keywords/common.robot
*** Test Cases ***

TC_001_Verify if a user is able to filter bus according to their ratings
    Open Make My Trip As
    Search Buses    Coimbatore    Trivandrum
    ${last_element}    Get All Bus Rating
    ${top_rating}    Get Top Rated Bus
    Check If Ratings Are Equal    ${last_element}    ${top_rating}

#verify that all buses are displayed when user unselects top rated icon again.