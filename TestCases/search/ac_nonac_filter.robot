*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource     ${EXECDIR}/Keywords/kw_customer.robot
Variables     ${EXECDIR}/Variables/search_data.yaml
Library    String
Library    SeleniumLibrary
*** Test Cases ***
TC_001
   [Documentation]  Verify that user can select only AC filter  and is not able to select both AC and NOn AC
   ...  Author: Akarsh
   ...  Steps:
   ...  1.Open browser 
   ...  2.enter url : www.makemytrip.com
   ...  3.close the pop up
   ...  4.click on bus icon
   ...  5.click on from input box
   ...  6.enter place
   ...  7.click desired place from autosuggestion
   ...  8.click on to input box
   ...  9.enter desired place 
   ...  10.click desired place from autosuggestion
   ...  11.click on travel date
   ...  12.click on desired date
   ...  13.click on search button
   ...  14.click on AC button 
   ...  14.Verify user is not able to select both  AC and Non AC filter
   ...  15.Verify user is able to see only ac bus   
   ...  Expected Result: User is able to select only ac filter and user is able to see only ac bus card 
   ...

   [Tags]      selectOne
   Log     ${SUITE NAME}
   Open Make My Trip As 
   Search Buses     
   Select Filters  AC  AC
   Get all bus   A/C
   Verify filter
TC_002
   [Documentation]  Verify that user can select only Non AC filter  and is not able to select both AC and NOn AC
   ...  Author: Akarsh
   ...  Steps:
   ...  1.Open browser 
   ...  2.enter url : www.makemytrip.com
   ...  3.close the pop up
   ...  4.click on bus icon
   ...  5.click on from input box
   ...  6.enter place
   ...  7.click desired place from autosuggestion
   ...  8.click on to input box
   ...  9.enter desired place 
   ...  10.click desired place from autosuggestion
   ...  11.click on travel date
   ...  12.click on desired date
   ...  13.click on search button
   ...  14.click on Non AC button 
   ...  14.Verify user is not able to select both  AC and Non AC filter
   ...  15.Verify user is able to see only ac bus   
   ...  Expected Result: User is able to select only Non ac filter and user is able to see only non ac bus card 


   [Tags]      selectOne
   Log     ${SUITE NAME}
   Open Make My Trip As 
   Search Buses     
   Select Filters  AC  Non AC
   Get all bus   Non A/C
   Verify filter

TC_003
    [Documentation]  Verfiy user can select AC bus from filter
    ...  Author: Akarsh
   ...  Steps:
   ...  1.Open browser 
   ...  2.enter url : www.easemytrip.com
   ...  3.click on bus icon
   ...  4.click on from input box
   ...  5.enter place
   ...  6.click desired place from autosuggestion
   ...  7.click on to input box
   ...  8.enter desired place 
   ...  9.click desired place from autosuggestion
   ...  10.click on travel date
   ...  12.click on desired date
   ...  12.click on search button
   ...  13.click on Non AC button 
   ...  14.Verify user is not able to select both  AC and Non AC filter
   ...  15.Verify user is able to see only ac bus   
   ...  Expected Result: User is able to select only Non ac filter and user is able to see only non ac bus card
   
    
    Open ease my trip
    Search buse in ease my trip   29 August
    Select filter ease my trip filter
*** Keywords ***
Open ease my trip
    Open Browser    browser=chrome  url=https://www.easemytrip.com/?utm_campaign=788997081&utm_source=g_c&utm_medium=cpc&utm_term=b_easy%20trip&adgroupid=36596366090&gad_source=1&gclid=Cj0KCQjwz7C2BhDkARIsAA_SZKbegF977eLRMR21yXOdoegcDhGZjdaKo_ZfigRjQ21Ojhvmd9fKf_0aAjyiEALw_wcB
    Maximize Browser Window
    Wait Until Element Is Visible    //div[@class='_menurohdr']//li[@class='bus mainMenu']  10s
    Click Element    //div[@class='_menurohdr']//li[@class='bus mainMenu']
Search buse in ease my trip
   [Arguments]    ${date}=todays date
    ${day}    ${month}    Split String    ${date}    ${SPACE}
    Log  ${month}
    Wait Until Element Is Visible    txtSrcCity
    Click Element    txtSrcCity
    Input Text    txtSrcCity    Bangalore
    Wait Until Element Is Visible    //div[@ng-show="sourceDiv"]//li[1]  10s
    Run Keyword And Ignore Error    //div[@ng-show="sourceDiv"]//li[1]


    Wait Until Element Is Visible    txtDesCity
    Click Element    txtDesCity
    Input Text    txtDesCity    Mumbai
    Run Keyword And Ignore Error    //div[@ng-show="desDiv"]//li[1]   10s
    Run Keyword And Ignore Error  Click Element    //div[@ng-show="desDiv"]//li[1]
    

    ###### Set date #########
    Wait Until Element Is Visible    datepicker
    Click Element    datepicker
    Wait Until Element Is Visible    ui-datepicker-div
    Wait Until Element Is Visible    //table[@class='ui-datepicker-calendar']//td[contains(@class,'current-day')]
    ${dateselector}    Set Variable If  "${date}" == "todays date"
    ...    //table[@class='ui-datepicker-calendar']//td[contains(@class,'current-day')]
    ...    //span[text()='${month}']/ancestor::div[@id='ui-datepicker-div']//table//a[text()='${day}']
    Click Element    ${dateselector}
    Click Element    srcbtn
Select filter ease my trip filter
    Wait Until Element Is Visible    //div[@class='left_pannel']
    Wait Until Element Is Visible    //div[@class='rating dt1-sec pdtb10']/label[contains(text(),'AC')]
    Run Keyword And Ignore Error  Click Element   //div[@class='rating dt1-sec pdtb10']/label[contains(text(),'AC')]
    Wait Until Element Is Visible    //div[@class='list_box']
    ${count}  Get Element Count    //div[@class='list_box']
    Log  ${count}
