*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource     ${EXECDIR}/Keywords/kw_customer.robot
Resource    ../Keywords/common.robot
*** Test Cases ***
TC_001 Verify user is able to get bus list according to the ascending duration
    [Documentation]  
    ...     Verify user is able to get bus list according to the ascending and descending duration
    ...     Step 1: Click on the fastest down arrow; buses with the shortest duration appear in order.
    ...     Step 2: Verify the duration is in descending order for both KSRTC and private buses. 

    Search Buses  Coimbatore   Trivandrum
    ${ascendingDurations}    select fastest and get bus duration       
    Validate Durations Sorted    ${ascendingDurations}   ascending

TC_002 Verify user is able to get bus list according to descending duration
   [Documentation]  
    ...     Verify user is able to get bus list according to the  descending duration
    ...     Step 1: Click on the fastest down arrow; buses with the longest duration appear in order.
    ...     Step 2: Verify the duration is in descending order for both KSRTC and private buses. 

    ${descendingDurations}    select fastest and get bus duration    
    Validate Durations Sorted   ${descendingDurations}  descending  

#Verify that relevance sort has only one order of display