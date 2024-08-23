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



