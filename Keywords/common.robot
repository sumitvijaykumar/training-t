*** Settings ***
Library     SeleniumLibrary
Library    collections
Library    String

*** Keywords ***

Open Make My Trip As
    Open Browser  browser=chrome        url=https://www.makemytrip.com
    Maximize Browser Window
    Wait Until Element Is Visible  //span[@class='commonModal__close']   10s
    Click Element    //span[@class='commonModal__close']

Select Filter

    [Arguments]     ${filterType}     ${filterExactText}
    # take the initial count
    Click Element     toggle_buses
    ${initialCount}    Get Element Count     //div[@class="busCardContainer "]     # maximum bus in search result, no filter applied
    Click Element    //div[contains(text(),'${filterType}')]/../..//span[text()='${filterExactText}']
    Wait Until Element Is Not Visible     //div[@class="busListingContainer"]//p[contains(text(),'found') and contains(text(),'${initialCount}')]
    #wait till its not the previous count or wait till elemnt disappears.
    sleep   10s

