*** Settings ***

Resource    ../../Keywords/kw_customer.robot
Resource    ../../Keywords/common.robot
Variables    ../../Variables/search_data.yaml

*** Test Cases ***

TC_001
    
    Open Make My Trip As
    Search Buses      
    Select Filter     Pick up point     Ettimadai
    Verify Pickups point    Ettimadai


TC_002
    [Documentation] 
    ...    Author: J Sreejith
    ...    Steps :
    ...    1.Open the Browser and Navigate to MakeMyTrip:
    ...    2.Select Multiple Pickup Points
    ...    3.Verify Multiple Selection
    ...
    ...    Expected result :
    ...    1.MakeMy Trip should be opened
    ...    2.Multiple pickup points are selected
    ...    3.Ensure that if Ettimadai is selected first and then Ukkadam is selected, both pickup points remain selected.
    ...    
    [Tags]    SelectMany
    Open Make My Trip As
    Search Buses
    Verify Multiple Selection in Pickup Points
    