*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource     ${EXECDIR}/Keywords/kw_customer.robot
Variables    ${EXECDIR}/Variables/search_data.yaml

*** Test Cases *** 

TC_001
    [Documentation]    Verify if a user is able to filter bus according to their seat preference  
    ...    Author : Gayathri M
    ...    Step 1 : Enter url of make my trip, enlarge the window
    ...    Step 2 : Close the window coming up, select bus icon 
    ...    Step 3 : Select from, to city,  date and search buses
    ...    Step 4 : Select seat type and verify it
    ...    Expected result : Only the buses with preferred seat type should appear.

    # [Tags]    selectOne
    Open Make My Trip As
    Search Buses     ${${SUITE_NAME}.${TEST_NAME}.FROM}    ${${SUITE_NAME}.${TEST_NAME}.TO}  
    Select Filter     Seat type     Sleeper
    ${numberOfBuses}    Get All Bus Id         
    Verify Seat Type    ${numberOfBuses}    Seat type    Sleeper

TC_002
    [Documentation]    Verify that only one filter can be selected from : 'Sleeper'  and 'Seater'
    ...    Author : Gayathri M
    ...    Step 1 : Enter url of make my trip, enlarge the window
    ...    Step 2 : Close the window coming up, select bus icon 
    ...    Step 3 : Select from, to city,  date and search buses
    ...    Step 4 : Select one seat type and verify it
    ...    Step 5 : Select other seat type 
    ...    Expected result : The previous selected filter must be automatically disabled while selecting other filter.
    
    [Tags]    selectOne
    Open Make My Trip As
    Search Buses     ${${SUITE_NAME}.${TEST_NAME}.FROM}    ${${SUITE_NAME}.${TEST_NAME}.TO}  
    Select Filter     Seat type     Sleeper
    ${numberOfBuses}    Get All Bus Id         
    Select Other Filter    Seat type    Sleeper    Seater     

TC_003
    [Documentation]    Verify if a user is able to filter bus according to their seat preference
    ...    Author : Gayathri M
    ...    1. Open browser 
    ...    2. Enter url : www.easemytrip.com
    ...    3. Click on bus icon
    ...    4. Click on input box and input from city
    ...    5. Click desired place from autosuggestion
    ...    6. Click on input box and enter to city 
    ...    7. Click desired place from autosuggestion
    ...    8. Click on travel date and select desired date
    ...    9. Click on search button
    ...    10.Click on Sleeper check box   
    ...    Expected Result: Get number of bus with sleeper seat type 

    Open Ease My Trip 
    Bus Search    Coimbatore    Trivandrum
    Filter Select    Sleeper

*** Keywords ***
Open Ease My Trip 
    Open Browser  browser=chrome        url=https://www.easemytrip.com/
    Maximize Browser Window
    Sleep    3s
Bus Search

    [Arguments]    ${fromCity}    ${toCity}    ${date}=today's date

    ${day}    ${month}    Split String    ${date}    ${SPACE}
    Wait Until Element Is Visible    //li[@class="bus mainMenu"]    10s
    Click Element    //li[@class="bus mainMenu"]
    Sleep    5s
    Wait Until Element Is Visible    txtSrcCity      10s
    Click Element    txtSrcCity
    Wait Until Element Is Visible    //input[@placeholder="Source City"]    10s
    Input Text    //input[@placeholder="Source City"]    ${fromCity}
    Sleep    5s
    Wait Until Element Is Visible    //*[@id="srcNav"]/li[1]    10s
    Click Element    //*[@id="srcNav"]/li[1]
    Sleep    5s
    Run Keyword And Ignore Error    Click Element    txtDesCity
    Wait Until Element Is Visible    //input[@placeholder="Destination City"]    10s
    Input Text    //input[@placeholder="Destination City"]    ${toCity}
    Wait Until Element Is Visible    //li[@ng-repeat="des in destinationCity" and contains(text(),"${toCity}")]    10s
    Click Element    //li[@ng-repeat="des in destinationCity" and contains(text(),"${toCity}")]
 
    Run Keyword And Ignore Error    Click Element    datepicker
    ${datelocator}    Set Variable If    "${date}"=="today's date"
    ...    //a[contains(@class,"ui-state-active")]
    ...    //a[contains(@class,"ui-state-active")]
    Scroll Element Into View    ${datelocator}
    Wait Until Element Is Visible    ${datelocator}    10s
    Click Element    ${datelocator}
    Click Element    srcbtn
    Wait Until Element Is Visible    idListingBus    5s


Filter Select
    [Arguments]    ${filterExactText}
    Scroll Element Into View    //*[@class="left_pannel"]//label[contains(text(),"${filterExactText}")]
    Click Element    //label[@class="container_b" and contains(text(),"${filterExactText}")]
    #Wait Until Element Is Visible    //input[@id="disSleeper" and contains(@class,"ng-not-empty")]    10s
    Wait Until Element Is Visible    //div[@class='list_box']
    ${count}    Get Element Count    //div[@class='list_box']
    Log    ${count}
    