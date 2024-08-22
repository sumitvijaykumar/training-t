*** Settings ***

*** Test Cases ***
TC-001 Verify if a user is able to filter bus according to price
    Open Make My Trip As
    Search Buses    ${from}    ${to}     
    Select Cheapest
    Get All Bus Price and verify
    

TC-002 Verify if a user is able to filter bus according to Travel Operator

    Open Make My Trip Ask
    Search Buses    ${from}    ${to}
    Select Filter    Travel Operators     A1 Travels
    Get filtered Bus Name    Travel Operators     A1 Travels
    Initial condition   Travel Operators


TC-003 Verify if a user is able to filter bus according to their seat preference
    
    Open Make My Trip As
    Search Buses    ${from}    ${to}    #${date}
    Select Filter     Seat type     Sleeper
    Get All Bus Id    Seat type     Sleeper


TC-004 Verify if a user is able to filter bus according to their drop point
    Open Make My Trip As
    Search Buses    ${from}    ${to}
    Select Filter    Drop point     Pattam   
    Verify Filter    Pattam  


TC-005 Verify if a user is able to filter bus according to ac and non ac
   Search bus    ${from}    ${to}    
   Select filter  AC  Non AC
   Get all bus   Non A/C
   Verify filter


TC-006 Verify if a user is able to filter bus according to their pick-up point
    
    Open Make My Trip As
    open link for Make My
    Set Suite Variable    ${today}    ${today}
    Search Buses    Coimbatore    Trivandrum             
    Select Filter     Pick up point     Ettimadai
    pickups and drop    Ettimadai

TC-007 Verify if a user is able to filter bus according to their preference and clear the filter
    
    Select Filter    AC    AC
    Select Filter    Seat type    Sleeper
    Select Filter    Seater/    Single
    Select Filter    Pick up point    Ettimadai
    Select Filter    Pick up time    6 AM to 11 AM
    Select Filter    Travel Operators    A1 Travels
    Select Filter    Drop point    Kazhakootam
    Select Filter    Drop time    6 AM to 11 AM
    Clear Filter           

TC-008 Verify if a user is able to filter bus according to their ratings
    Open Make My Trip As
    Search Buses    ${from}    ${to}
    Get All Bus Rating
    Get Top Rated Bus
    Check If Ratings Are Equal    ${last_element}    ${top_rating}

TC-009 Verify the departure date of buses should be same as entered
    Open Make My Trip As
    Search Buses    ${from}    ${to}
    ${allBusDate}    ${numberOfBuses}    Get All Bus Date
    ${inputDate}    Get Input Date
    Validating Data    ${allBusDate}    ${numberOfBuses}    ${inputDate}


TC-010 Verify Initial toggle to shortest duration
    Open Make My Trip As
    Search Buses    ${from}    ${to}
    Toggle Fastest Sorting And Validate 


TC-011 Verify if a user is able to filter bus according to their drop time
    Open Make My Trip As
    Search Buses    ${from}    ${to}    ${date}
    Select Filter    Drop time    6 AM to 11 AM
    Filter time