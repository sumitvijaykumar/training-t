*** Settings ***

*** Test Cases ***
TC-001 Verify if a user is able to filter bus according to their seat preference
    Open Make My Trip As
    Search Buses    ${from}    ${to}     
    Select Cheapest
    Get All Bus Price and verify
    

TC-002 Verify if a user is able to filter bus according to their preference

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