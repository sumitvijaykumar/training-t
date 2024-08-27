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

TC_003
    Open is my trip
    Search Bus    Bangalore    Ernakulam     30 August   
    Filter bus according to pickup point    Boarding Points    Chinnappanahalli        

*** Keywords ***

Open is my trip
    Open Browser  browser=chrome        url=https://www.easemytrip.com
    Maximize Browser Window
    

Search Bus
    [Arguments]    ${from}    ${to}    ${date}=today

     ${day}    ${month}    Split String    ${date}    ${SPACE}

    Wait Until Element Is Visible    //li[@class='bus mainMenu']   10s
    Click Element    //li[@class='bus mainMenu']
    Wait Until Element Is Visible    txtSrcCity    2s
    Click Element    txtSrcCity
    Wait Until Element Is Visible    //div[@class="drop3"]
    Input Text    //input[@name='txtSrcCity']    ${from}    
    Wait Until Element Is Visible    //div[@class='drop3']//li[contains(text(),'${from}')]    


    Run Keyword And Ignore Error    Click Element     txtDesCity
    Wait Until Element Is Visible    //div[@class="drop3"]
    Input Text    //input[@name='txtDesCity']    ${to}

    
    Click Element    datepicker
    Wait Until Element Is Visible    //table[contains(@class,"calendar")]
    ${datelocator}    Set Variable If    '${date}' == 'today'    //a[contains(@class,'ui-state-active')]    //span[text()='${month}']/../../following-sibling::table//a[contains(@class,'ui-state-') and (text()='${day}')]
    Click Element    ${datelocator}
    Click Element    srcbtn
    Sleep    10s
    ${count}    Get Element Count    //div[contains(@class,"list_box")]
    Log    ${count}


Filter bus according to pickup point

    [Arguments]    ${filtertype}    ${filtername}
    Run Keyword And Ignore Error    Click Element    ShowBusBox0
    
    Scroll Element Into View    //div[@class='scroll-x']//label[@title='${filtername}']    
    Click Element    //div[contains(text(),'${filtertype}')]/../..//label[@title='${filtername}']
    Sleep    10s

