*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource     ${EXECDIR}/Keywords/kw_customer.robot
Resource    ../../Keywords/common.robot
Resource    ../../Keywords/kw_customer.robot
Variables    ../../Variables/search_data.yaml
*** Test Cases ***

TC_001
    [Documentation]    Verify the departure date of buses should be same as entered
    ...    Author: Albin
    ...    Steps
    ...    1: Open the browser and go to the make my trip page using the url
    ...    2: Click on the close icon on the pop screen window
    ...    3: Click on the buses icon
    ...    4: Click on the from input box and give input coimbatre
    ...    5: Click on the to input box and give input trivandram
    ...    6: click on travel date and click on the date shows inthe calender
    ...    7: Click on search button
    ...    8: Click on view buses in the ksrtc card
    ...    9: Verify the date we gave is same as the dates in the bus card  
    Open Make My Trip As
    Search Buses
    ${allBusDate}    ${numberOfBuses}    Get All Bus Date
    ${inputDate}    Get Input Date
    Validating Data    ${allBusDate}    ${numberOfBuses}    ${inputDate}

TC_002
    [Documentation]    Verify the departure date i.e, (click today in departure date section) of buses should be same as today
    ...    Author: Albin
    ...    Steps
    ...    1: Open the browser and go to the make my trip page using the url
    ...    2: Click on the close icon on the pop screen window
    ...    3: Click on the buses icon
    ...    4: Click on the from input box and give input coimbatre
    ...    5: Click on the to input box and give input trivandram
    ...    6: click on travel date and click on the date shows inthe calender
    ...    7: Click on search button
    ...    8: Click on today in daparture date
    ...    9: Click on view buses in the ksrtc card
    ...    10: Verify the date we gave(i.e,) is same as the dates in the bus card  
    [Tags]    selectone
    Open Make My Trip As
    Search Buses
    Click todays date
    ${allBusDate}    ${numberOfBuses}    Get All Bus Date
    ${inputDate}    Get Input Date
    Validating Data    ${allBusDate}    ${numberOfBuses}    ${inputDate}

TC_003
    [Documentation]    Verify the departure time filter i.e, (click a time section in departure time section) of buses should should show buses in that time
    ...    Author: Albin
    ...    Steps
    ...    1: Open the browser and go to the ease my trip page using the url
    ...    2: Click on the buses icon
    ...    3: Click on the from input box and give input coimbatre
    ...    4: Click on the to input box and give input thiruvanandhapuram
    ...    5: click on travel date and click on the date shows inthe calender
    ...    6: Click on search button
    ...    7: Click on toAfternoon setion in daparture time
    ...    8: Click on view buses in the ksrtc card
    ...    9: count the buses
    Open Ease My Trip As
    Searching Buses    #Coimbatore    Thiruvananthapuram
    Click Filter
*** Keywords ***

Open Ease My Trip As
    Open Browser  browser=chrome        url=https://www.easemytrip.com
    Maximize Browser Window

Searching Buses
    [Arguments]    ${date}=""
    Wait Until Element Is Visible   //li[contains(@class,"bus")]
    Click Element  //li[contains(@class,"bus")]
    Wait Until Element Is Visible   txtSrcCity      10s
    Click Element    txtSrcCity
    Wait Until Element Is Visible  //div[contains(@ng-show,"sourceDi")]
    Input Text   txtSrcCity   ${${SUITE_NAME}.${TEST_NAME}.FROM}
    Wait Until Element Is Visible  //div[@ng-show="sourceDiv"]//li[1]     10s
    Run Keyword And Ignore Error    Click Element  //div[@ng-show="sourceDiv"]//li[1]
    
    Run Keyword And Ignore Error  Click Element    txtDesCity
    Wait Until Element Is Visible  //div[contains(@ng-show,"desDi")]
    Input Text   txtDesCity  ${${SUITE_NAME}.${TEST_NAME}.TO}
    Wait Until Element Is Visible  //div[@ng-show="desDiv"]//li[1]    10s
    Run Keyword And Ignore Error    Click Element  //div[@ng-show="desDiv"]//li[1]

    Click Element    datepicker
    Wait Until Element Is Visible    //table[contains(@class,"calendar")]
    ${datelocator}  Set Variable If   ${date}==""
    ...    //td[contains(@class,'current-day')]
    ...    //a[contains(@class,'ui-state-default') and text()='${date}'] 
    Click Element    ${datelocator}    #//span[text()='August']/ancestor::div[@id='ui-datepicker-div']//table//a[text()='29']
    Click Element    srcbtn
Click Filter
    
    Click Element    AFTERNOON
    Click Element    ShowBusBox0
    ${count}    Get Element Count    //div[contains(@class,"list_box")]
    Sleep    10s