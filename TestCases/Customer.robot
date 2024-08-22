*** Settings ***

*** Test Cases ***
TC-001 Verify if a user is able to filter bus according to their seat preference
    Open Make My Trip As
    Search Buses    ${from}    ${to}     
    Select Cheapest
    Get All Bus Price and verify
    

TC-001 Verify if a user is able to filter bus according to their seat preference
    
    Open Make My Trip As
    open link for Make My
    Set Suite Variable    ${today}    ${today}
    Search Buses    Coimbatore    Trivandrum             
    Select Filter     Pick up point     Ettimadai
    pickups and drop    Ettimadai

