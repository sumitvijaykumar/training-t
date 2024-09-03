*** Settings ***
Library     SeleniumLibrary
Library    collections
Library    String
Resource   ${EXECDIR}/POM/pom_common.robot

*** Keywords ***

Open Make My Trip As
    Open Browser  browser=chrome        url=https://www.makemytrip.com
    Maximize Browser Window
    Wait Until Element Is Visible  ${popup_signup}   10s
    Click Element    ${popup_signup}

Select Filter

    [Arguments]     ${filterType}       ${filterExactText}=''
    ${filterExactTextFinal}          Set Variable If    ${filterExactText}==''      ${${SUITE_NAME}.${TEST_NAME}.VALUE}          ${filterExactText}
    # take the initial count
    Click Element     toggle_buses
    ${initialCount}    Get Element Count     //div[@class="busCardContainer "]     # maximum bus in search result, no filter applied
    Click Element    //div[contains(text(),'${filterType}')]/../..//span[text()='${filterExactTextFinal}']
    Wait Until Element Is Not Visible     //div[@class="busListingContainer"]//p[contains(text(),'found') and contains(text(),'${initialCount}')]
    #wait till its not the previous count or wait till elemnt disappears.
    sleep   10s

