*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource     ${EXECDIR}/Keywords/kw_customer.robot
Resource    ../Keywords/common.robot
Variables   ${EXECDIR}/Variables/search_data.yaml


*** Test Cases ***
TC_001
    [Documentation]     Verify the user is able to filter Buses using "Travel Operator" filter type.
    ...    AUTHOR: Archana Rajan
    ...    STEPS:: 
    ...    1.  Open the browser
    ...    2.  Enter the MakeMyTrip link
    ...    3.  Close all the pop-ups if they appear
    ...    4.  Click on Bus Icon
    ...    5.  Enter "From", "To" destinations  and click on today's date if date is not specified
    ...    6.  Click on "Search" button
    ...    7.  Click on "A1 Travel" checkbox in "Travel Operators" filter
    ...    8.  Take the count of Buses displayed  before and after clicking the filter, If the count is same then test fails
    ...    9.  Create a empty list and add the Busname into it
    ...    10. Display the list 
    ...    11. Verify the filter by comparing each element in list with selected travel operator, if it does not matches then test fails
    ...    12. Click on "clear" to uncheck the selected filters
    ...    13. Close the browser
    ...    
    ...    EXPECTED RESULTS:
    ...    1.  The google browser should open and maximise the window
    ...    2.  User should be able to access the MakeMyTrip Link
    ...    3.  Click on the close buttons of pop-ups
    ...    4.  User should enter the homepage and click on Bus Icon
    ...    5.  User should be able to click and  "From", "To" destinations  and click on today's date if date is not specified in search page
    ...    6.  User should be able to click on Search button and redirect into Selection page
    ...    7.  User should be able to click on "A1 Travel" checkbox in "Travel Operators" filter
    ...    8.  User hould be able to view and take count of buses available before and after filter applying
    ...    9.  List of filtered buses should display
    ...    10. The selected filter and bus name should match
    ...    11. User should be able to click on clear button to undo all the filters
    ...    12. The browser should exit
    [Tags]      SelectOne 



    Open Make My Trip As
    Search Buses
    Select Filter    Travel Operators
    Get filtered Bus Names And Verify    Travel Operators
    Clear Travel Operator Filter     Travel Operators


TC_002
    [Documentation]        Verify the user can select more than one choice from the "Travel Operator" filter and check  the prior checkbox is still selected.
    ...    AUTHOR: Archana Rajan
    ...    STEPS:: 
    ...    1.  Open the browser
    ...    2.  Enter the MakeMyTrip link
    ...    3.  Close all the pop-ups if they appear
    ...    4.  Click on Bus Icon
    ...    5.  Enter "From", "To" destinations  and click on today's date if date is not specified
    ...    6.  Click on "Search" button
    ...    7.  Click on "A1 Travel" checkbox in "Travel Operators" filter
    ...    8.  Click on "KSRTC(Kerala)" checkbox in "Travel Operators" filter
    ...    9.  Check "A1 Travel" checkbox is still selected, otherwise Test Case fails
    ...    10. Click on "Clear" to remove all filters applied
    ...    11. Close the browser
    ...    
    ...    EXPECTED RESULTS:
    ...    1.  The google browser should open and maximise the window
    ...    2.  User should be able to access the MakeMyTrip Link
    ...    3.  Click on the close buttons of pop-ups
    ...    4.  User should enter the homepage and click on Bus Icon
    ...    5.  User should be able to click and  "From", "To" destinations  and click on today's date if date is not specified in search page
    ...    6.  User should be able to click on Search button and redirect into Selection page
    ...    7.  User should be able to click on "A1 Travel" checkbox in "Travel Operators" filter
    ...    8.  User should be able to click on "KSRTC(Kerala)" checkbox in "Travel Operators" filter
    ...    9.  "A1 Travels" checkbox should be selected along with "KSRTC(Kerala)"checkbox
    ...    10. User should be able to click on clear button to undo all the filters
    ...    11. The browser should exit  
    [Tags]     SelectMany


    Open Make My Trip As
    Search Buses
    Select Filter    Travel Operators
    Select Multiple Options In Filter    Travel Operators
    Check Previous Filter Present Or Not
    Clear Travel Operator Filter     Travel Operators     