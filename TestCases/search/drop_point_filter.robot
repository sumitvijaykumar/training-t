*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource     ${EXECDIR}/Keywords/kw_customer.robot
Resource    ../Keywords/common.robot
Variables    ${EXECDIR}/Variables/search_data.yaml
Library    SeleniumLibrary
Library    yaml
*** Test Cases ***

TC_001
    [Documentation] 
    ...  Verify if a user is able to filter bus according to their drop point
    ...  Author: Gokul
    ...  Steps:
    ...  open make my trip
    ...  go to busses page
    ...  search busess from and to cities
    ...  select the drop point
    ...  verify results shown has the selected drop point
    [Tags]    selectone

    Open Make My Trip As
    Search Buses   
    Select Filter     Drop point     ${${SUITE_NAME}.${TEST_NAME}.DROP_POINT}
    Verify drop point     ${${SUITE_NAME}.${TEST_NAME}.DROP_POINT}

# 002
# Verify that user can select multiple drop points
TC_002
    [Documentation]
    ...    Verify if user is able to select multiple drop points
    ...    Author:Gokul
    ...    steps:
    ...    open make my trip
    ...    go to busses page
    ...    search buses from and to cities
    ...    select two or more drop points
    ...    check user can select two or more drop points
    [Tags]    selectmany
    
    Open Make My Trip As
    Search Buses  
    Select Filter    Drop point    ${${SUITE_NAME}.${TEST_NAME}.DROP_POINT1}
    Select Filter     Drop point     ${${SUITE_NAME}.${TEST_NAME}.DROP_POINT2} 
    verify multiple drop points selected
    

TC_003
    [Documentation]
    ...    Get the count of buses of a drop point in ease my trip
    Open Ease My Trip
    Search in buses    Coimbatore    Thiruvananthapuram    29
    select drop point and get count    Dropping Points      Ulloor



*** Keywords ***
Open Ease My Trip
    Open Browser    browser=chrome    url=https://www.easemytrip.com
    Maximize Browser Window
    Click Element    //div[@id="myTopnav"]//li[contains(@class,"bus")]
    Wait Until Page Contains Element    search    15s


Search in buses
    [Arguments]    ${from}    ${to}    ${date}=today
    Click Element    txtSrcCity
    Input Text    txtSrcCity    ${from}
    Wait Until Element Is Visible    //ul[@id="srcNav"]//li[contains(text(),"${from}")]
    Run Keyword And Ignore Error    Click Element    //ul[@id="srcNav"]//li[contains(text(),"${from}")]
    Click Element    txtDesCity
    Input Text    txtDesCity    ${to}
    Wait Until Element Is Visible    //ul[@id="desNav"]//li[contains(text(),"${to}")]
    Run Keyword And Ignore Error    Click Element    //ul[@id="desNav"]//li[contains(text(),"${to}")]
    Click Element    datepicker
    Click Element    //div[contains(@class,"datepicker")]//td[contains(@class,'${date}') or (a[contains(text(),'${date}')])]
    # Click Element    //div[contains(@class,"datepicker")]//td[contains(@class,"${date}")]
    Click Element    srcbtn
    Sleep    10s

select drop point and get count
    [Arguments]    ${filtername}    ${drop_point}
    Click Element    //div[contains(text(),"${filtername}")]/../following-sibling::div//label[@title="${drop_point}"]
    Run Keyword And Ignore Error    Click Element    //a[@id="ShowBusBox0" and contains(text(),"Show Buses")]
    ${count}    Get Element Count    //div[@class="list_box"]
    Log    ${count}


