*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library     String
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


TC_003
    [Documentation]     Verify the user is able to filter Buses using "Bus Operator" filter type.
    ...    AUTHOR: Archana Rajan
    ...    STEPS:: 
    ...    1.  Open the browser
    ...    2.  Enter the EaseMyTrip link
    ...    4.  Click on Bus Icon
    ...    5.  Enter "From", "To" destinations  and click on today's date if  depature date is not specified
    ...    6.  Click on "Search" button
    ...    7.  Click on "A1 Travel" checkbox in "Bus Operators" filter
    ...    8.  Take the count of Buses displayed  before and after clicking the filter, If the count is same then test fails
    ...    9.  Create a empty list and add the Busname into it
    ...    10. Display the list
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

    Open Browser and enter EaseMyTrip link
    Navigate into Bus Section and Enter Search Data   Coimbatore  Trivandrum     August    28
    Click On Bus Operator Filter And Get The Results     Bus Operator       A1 Travels


*** Keywords ***

Open Browser and enter EaseMyTrip link

    Open Browser       browser=chrome   url=https://www.easemytrip.com
    Maximize Browser Window

Navigate into Bus Section and Enter Search Data 
    [Arguments]   ${SourceCity}    ${DestinationCity}    ${month}    ${date}

    #${day}    ${month}    Split String    ${date}    ${SPACE}

    Click Element   //li[@class="bus mainMenu"]//span[text()="Bus"]
    
    Click Element     txtSrcCity
    Wait Until Element Is Visible     //input[@placeholder='Source City']     10s
    Input Text    txtSrcCity    ${SourceCity}


    Click Element     txtDesCity
    Wait Until Element Is Visible     //input[@placeholder='Destination City']         10s
    Input Text    txtDesCity    ${DestinationCity}


    Click Element    datepicker
    Page Should Contain Element        //span[contains(@class,'month') and text()='${month}'] 
    #${is_present}=    Run Keyword And Return Status    Page Should Contain Element    //span[contains(@class,'month') and text()='${month}'] 


    ${datelocator}  Set Variable If   "${date}"==""
    ...    //td[contains(@class,'current-day')]
    ...    //a[contains(@class,'ui-state-default') and text()='${date}']      #//td[(@data-handler='selectDay')]/a[text()='28']     //a[contains(@class,'ui-state-default') and text()='28']
    Click Element   ${datelocator}
          
    Click Element     srcbtn    #search button

Click On Bus Operator Filter And Get The Results

    [Arguments]    ${BusFilter}    ${BusFilterExact}

    Wait Until Element Is Visible     //label[@title='${BusFilterExact}']       10s
    Click Element                       //label[@title='${BusFilterExact}']      #//div[contains(text(),'${BusFilter}')]/ancestor::div[@class='left_pannel']//span[text()='${BusFilterExact}']       #//label[@title='A1 Travels']

    @{allBusName}    Create List
    ${numberOfBuses}     Get Element Count    //div[@class="list_box"]
    ${numberOfBuses}    Evaluate     $numberOfBuses+1
    FOR    ${index}    IN RANGE     1    ${numberOfBuses}
    ${busName}     Get Text      (//span[contains(@class,'busName')])[${index}]         # node with text in it, exact 3 matches.
    Append To List     ${allBusName}    ${busName}

    END
    Log    ${allBusName}