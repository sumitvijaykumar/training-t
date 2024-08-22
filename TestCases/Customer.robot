*** Settings ***

*** Test Cases ***
TC-001 Verify if a user is able to filter bus according to their seat preference
    Open Make My Trip As
    Search Buses    ${from}    ${to}     
    Select Cheapest
    Get All Bus Price and verify
    

TC-002 Verify if a user is able to filter bus according to Travel Operator

    Connect To Browser
    Enter MakeMyTrip Link
    Search Buses    ${fromCity}        ${toCity}     ${month}   23 Aug
    Select Filter    Travel Operators     A1 Travels
    Get filtered Bus Name    Travel Operators     A1 Travels
    Verify Busname    Travel Operators     A1 Travels    ${allBusName}
    Initial condition   Travel Operators

TC-004 Verify if a user is able to filter bus according to their drop point
    Open Make My Trip As
    Search Buses    Coimbatore    Thiruvananthapuram
    Select Filter    Drop point     Pattam   
    Verify Filter    Pattam  
TC-003 Verify if a user is able to filter bus according to their seat preference
    
    Open Make My Trip As
    Search Buses    ${from}    ${to}    #${date}
    Select Filter     Seat type     Sleeper
    Get All Bus Id    Seat type     Sleeper
TC-005 Verify if a user is able to filter bus according to ac and non ac
   Search bus    Coimbatore   Trivandrum    
   Select filter  AC  Non AC
   Get all bus   Non A/C
   Verify filter

TC-006 Verify if a user is able to filter bus according to their seat preference
    
    Open Make My Trip As
    open link for Make My
    Set Suite Variable    ${today}    ${today}
    Search Buses    Coimbatore    Trivandrum             
    Select Filter     Pick up point     Ettimadai
    pickups and drop    Ettimadai