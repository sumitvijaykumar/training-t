*** Settings ***

*** Test Cases ***

TC-002 Verify if a user is able to filter bus according to their preference

    Connect To Browser
    Enter MakeMyTrip Link
    Search Buses    ${fromCity}        ${toCity}     ${month}   23 Aug
    Select Filter    Travel Operators     A1 Travels
    Get filtered Bus Name    Travel Operators     A1 Travels
    Verify Busname    Travel Operators     A1 Travels    ${allBusName}
    Initial condition   Travel Operators