*** Settings ***
Resource    ${EXECDIR}/Keywords/common.robot
Resource     ${EXECDIR}/Keywords/kw_customer.robot
Variables   ${EXECDIR}/Variables/search_data.yaml


*** Test Cases ***
TC_001
   [Documentation]  Verify that only one filter can be selected from: "AC" and "Non AC"
   ...  Author: Akarsh
   ...  Steps:
   ...  1. 
   ...  2.
   ...  
   ...  Expected Result: 
   ...

   [Tags]      selectOne
   Given User sees "bus" booking page
   AND User Enters "Coimbatore" in "From"
   AND User Enters "Trivandrum" in "To"
   AND User Selects Date As "31" of "August" Month
   AND User does search
   AND User has list of all bus price      #@{govtBus}  ,   @{privateBus}    set test level variable
   When Sort By "Cheapest" in "ascending" order
   Then "KSRTC" bus should be sorted in "descending" order      #fetch the xpath and check sorting as per Govt. bus
   And "Private" bus should be sorted in "descending" order

*** Keywords ***


User sees "${serviceType}" booking page
    Open Browser  browser=chrome        url=https://www.makemytrip.com
    Maximize Browser Window
    Wait Until Element Is Visible  //span[@class='commonModal__close']   10s
    Click Element    //span[@class='commonModal__close']
    
    IF    $serviceType == 'bus'
        Wait Until Element Is Visible   //li[@class='menu_Buses']
        Click Element  //li[@class='menu_Buses']
    ELSE
        Run Keyword   FAIL   Please select a serviceType
    END

User Enters "${placeName}" in "${textBoxName}"
    Wait Until Element Is Visible   fromCity      10s
    Click Element    fromCity
    Wait Until Element Is Visible  //input[contains(@placeholder,'${textBoxName}')]
    Input Text   //input[contains(@placeholder,'${textBoxName}')]  ${fromCity}
    Wait Until Element Is Visible  //div[contains(@class,'autosuggest')]//span[contains(text(),'${placeName},')]
    Click Element  //div[contains(@class,'autosuggest')]//span[contains(text(),'${placeName},')]
    #verification point that above actions are successfully done. take some xpath to be visible.

User Selects Date As "${date}" of "${month}" Month
    Run Keyword And Ignore Error  Click Element    travelDate
    ${datelocator}  Set Variable If   "${date}"=="today's date"
    ...    //div[@class='DayPicker-Month']//div[@aria-selected='true']
    ...    //div[contains(text(),${month})]/ancestor::div[@class='DayPicker-Month']//div[contains(text(),${date})]
    Scroll Element Into View  ${datelocator}
    Wait Until Element Is Visible  ${datelocator}  10s
    Click Element   ${datelocator}
    #Add verification that selected date is displayed. take some xpath to be visible.

User does search
    Click Element   search_button
    Wait Until Element Is Visible     //div[@class="busListingContainer"]//p[contains(text(),'found')]

Sort By "${filterName}" in "${order}" order  
    [Documentation]   
    ...    ${filterName} argument is one of the value in "Relevance Fastest Cheapest Rating Arrival Departure"
    ...    ${order} argument is one of the value in"ascending" or "descending"
    ...    Example:
    ...    Sort By "Cheapest" in "ascending" order
    #[Setup]   CLick on relevance sort 

    Click Element    //div[@class="makeFlex hrtlCenter"]//li[contains(text(), '${filterName}')]

   
    IF     '${order}'=='ascending'
        Element Should Be VIsible   //li[contains(text(),'${filterName}')]/span[contains(@class,'rotate180')]
    ELSE IF   '${order}'=='descending'
        Element Should Be VIsible   //li[contains(text(),'${filterName}')]/span[not(contains(@class,'rotate180'))]
    ELSE
        Run Keyword         FAIL   enter correct order
    END


