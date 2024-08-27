*** Settings ***
Library    SeleniumLibrary
Library    Collections
   
*** Keywords ***
Search Buses
    [Arguments]     ${date}=today's date
    ${fromCity}        Set Variable     ${${SUITE_NAME}.${TEST_NAME}.FROM}
    ${toCity}          Set Variable     ${${SUITE_NAME}.${TEST_NAME}.TO}

    ${day}    ${month}    Split String    ${date}    ${SPACE}
    Wait Until Element Is Visible   //li[@class='menu_Buses']
    Click Element  //li[@class='menu_Buses']
    Wait Until Element Is Visible   fromCity      10s
    Click Element    fromCity
    Wait Until Element Is Visible  //input[contains(@placeholder,'From')]
    Input Text   //input[contains(@placeholder,'From')]  ${fromCity}
    Wait Until Element Is Visible  //div[contains(@class,'autosuggest')]//span[contains(text(),'${fromCity},')]
    Click Element  //div[contains(@class,'autosuggest')]//span[contains(text(),'${fromCity},')]
 
    Run Keyword And Ignore Error  Click Element    toCity
    Wait Until Element Is Visible  //input[contains(@placeholder,'To')]
    Input Text   //input[contains(@placeholder,'To')]  ${toCity}
    Wait Until Element Is Visible  //div[contains(@class,'autosuggest')]//span[contains(text(),'(${toCity})')]
    Click Element  //div[contains(@class, 'autosuggest')]//span[contains(text(),'${toCity},') or contains(text(),'(${toCity}),')]
 
    Run Keyword And Ignore Error  Click Element    travelDate
    ${datelocator}  Set Variable If   "${date}"=="today's date"
    ...    //div[@class='DayPicker-Month']//div[@aria-selected='true']
    ...    //div[contains(text(),${month})]/ancestor::div[@class='DayPicker-Month']//div[contains(text(),${day})]
    Scroll Element Into View  ${datelocator}
    Wait Until Element Is Visible  ${datelocator}  10s
    Click Element   ${datelocator}
    Click Element   search_button
    Wait Until Element Is Visible     //div[@class="busListingContainer"]//p[contains(text(),'found')]
Select Cheapest
    
    Click Element     toggle_buses
    ${Count}    Get Element Count     //div[@class="busCardContainer "]     # maximum bus in search result, no filter applied
    Click Element    //div[@class="makeFlex hrtlCenter"]//li[contains(text(), 'Cheapest')]
    
Get All Bus Price and verify
    @{allBusPrice}    Create List
    @{allKsrtcPrices}    Create List
    @{allPrivatePrices}  Create List
    
    ${busCount}    Get Element Count    //div[@class="busCardContainer "]//span[@id="price"]
    ${busCount}    Evaluate     $busCount+1
    FOR    ${index}    IN RANGE    1    ${busCount}
        ${price}    Get Text    (//div[@class="busCardContainer "]//span[@id="price"])[${index}] 
        ${price}    Evaluate    "${price}".replace(',', '') 
        ${price}    Convert To Integer    ${price}

        Append To List    ${allBusPrice}    ${price}  
    END
    FOR    ${index}    IN RANGE    1    ${busCount}

        ${busName}    Get Text    (//p[contains(@class, 'latoBold blackText')])[${index}]
        ${price}      Get Text    (//div[@class="busCardContainer "]//span[@id="price"])[${index}] 
        ${price}      Evaluate    "${price}".replace(',', '')
        ${intprice}    Convert To Integer      ${price}   
        ${found}=    Evaluate    'KSRTC' in '${busName}'
        IF    ${found}    
            Append To List    ${allKsrtcPrices}    ${intprice}
        ELSE
            Append To List    ${allPrivatePrices}    ${intprice}
        END
    END
    ${sorted_ksrtc_prices}    Copy List    ${allKsrtcPrices}
    Sort List    ${sorted_ksrtc_prices}
    ${sorted_ksrtc_prices_Desc}    Copy List    ${sorted_ksrtc_prices}
    Reverse List    ${sorted_ksrtc_prices_Desc}

    ${sorted_private_prices}    Copy List    ${allPrivatePrices}
    Sort List    ${sorted_private_prices}
    ${sorted_private_prices_Desc}    Copy List    ${sorted_private_prices}
    Reverse List    ${sorted_private_prices_Desc}
    

    @{combined_sorted_prices_desc}    Create List
    FOR    ${price}    IN    @{sorted_ksrtc_prices_Desc}
        Append To List    ${combined_sorted_prices_desc}    ${price}
    END
    FOR    ${price}    IN    @{sorted_private_prices_Desc}
        Append To List    ${combined_sorted_prices_desc}    ${price}
    END
    
    @{combined_sorted_prices_asc}    Create List
    FOR    ${price}    IN    @{sorted_ksrtc_prices}
        Append To List    ${combined_sorted_prices_asc}    ${price}
    END
    FOR    ${price}    IN    @{sorted_private_prices}
        Append To List    ${combined_sorted_prices_asc}    ${price}
    END
    ${is_sorted_correctly_asc}    Evaluate    ${allBusPrice} == ${combined_sorted_prices_asc}
    ${is_sorted_correctly_dec}    Evaluate    ${allBusPrice} == ${combined_sorted_prices_desc}
    
    IF    ${is_sorted_correctly_asc}
        Log    Prices are sorted correctly
    ELSE IF    ${is_sorted_correctly_dec}
        Log    Prices are sorted in descending order correctly
    ELSE
        Fail    Prices are not sorted correctly
    END
    
    Log    KSRTC Bus Prices: ${sorted_ksrtc_prices}
    Log    Private Bus Prices: ${sorted_private_prices}
    Log    Original Combined Prices: ${allBusPrice}
    Log    Combined Sorted Prices: ${combined_sorted_prices_asc}


Get all bus
    [Arguments]   ${filtername} 
    @{allACBus}  Create List
    Run Keyword And Ignore Error  Click element  //div[@id="toggle_buses" and not(contains(@class,'active'))]
    ${numberofbusses}  Get Element Count  //div[contains(@class,'busCardContainer')]
    ${numberofbusses}  Evaluate  $numberofbusses+1


    FOR  ${index}  IN RANGE  1  ${numberofbusses}
    ${ACBus}   Get Text  (//div[contains(@class,'busCardContainer')]//p[contains(@class,'secondaryTxt')])[${index}]
    Log  ${ACBus}
    Append To List  ${allACBus}   ${ACBus}
    END
    Log   ${allACBus}
    ${str}  Remove String  ${filtername}  /
    Set Test Variable    ${str}    ${str}
    Set Test Variable    @{allACBus}   @{allACBus}
    Set Test Variable    ${filtername}  ${filtername} 

Verify filter
    Log  ${allACBus}
    FOR    ${element}    IN    @{allACBus}
        Should Contain Any  ${element}    ${str}    ${filtername}
    END

Get All Bus Date
    @{allBusDate}    Create List
    run keyword and ignore error     Click Element     //div[@id="toggle_buses" and not(contains(@class,'active'))]
    ${numberOfBuses}     Get Element Count    //div[starts-with(@id,"bus_")]
    ${numberOfBuses}    Evaluate     $numberOfBuses+1
    FOR    ${index}    IN RANGE     1    ${numberOfBuses}
        ${busDate}     Get Text       (//span[contains(@class,"latoBlack blackText")]/following-sibling::span[contains(@class,"secondaryTxt")])[${index}]          
        Append To List     ${allBusDate}    ${busDate}
    END
    Log    ${allBusDate}
    RETURN    ${allBusDate}    ${numberOfBuses}

Get Input Date
    ${busDate}    Get Element Attribute    //input[@data-testid="travelDate"]    value
    ${busDate}    Split String    ${busDate}    ${SPACE}
    Set Test Variable    ${day}    ${busDate}[1]
    Set Test Variable    ${month}    ${busDate}[2]
    ${dateMonth}    Catenate    ${day}    ${month}
    ${dateMonth}    Convert To Upper Case    ${dateMonth}
    RETURN    ${dateMonth}

Validating Data
    [Arguments]    ${allBusDate}    ${numberOfBuses}    ${dateMonth}
    ${numberOfBuses}    Evaluate     $numberOfBuses-1
    FOR    ${count}    IN RANGE    ${numberOfBuses}
        ${busDate}    Set Variable    ${allBusDate}[${count}]
        Should Be Equal    ${dateMonth}    ${busDate}
    END



et filtered Bus Names And Verify
    [Documentation]  Adding Travel Operator's name into a list and comparing them with selected filter name

    [Arguments]    ${filterType}   ${BUS_NAME}   
    @{allBusName}    Create List
    run keyword and ignore error     Click Element     //div[@id="toggle_buses" and not(contains(@class,'active'))]
    ${numberOfBuses}     Get Element Count    //div[starts-with(@id,"bus_")]//p[text()="${BUS_NAME}"]
    ${numberOfBuses}    Evaluate     $numberOfBuses+1
    FOR    ${index}    IN RANGE     1    ${numberOfBuses}
    ${busName}     Get Text      (//div[starts-with(@id,"bus_")]//p[text()="${BUS_NAME}"])[${index}]         # node with text in it, exact 3 matches.
    Append To List     ${allBusName}    ${busName}

    END
    Log    ${allBusName}

    FOR    ${i}    IN    @{allBusName}
    Should Be Equal As Strings     ${BUS_NAME}    ${i}
    END

Clear Travel Operator Filter    
    [Arguments]     ${filterType}

    #Click Element     //div[@class="filterContainer"]//p[text()="CLEAR ALL"]
    Click Element      //div[text()="${filterType}"]/following-sibling::div[text()="CLEAR"]






Get All Bus Rating
    @{allBusRating}    Create List
    Run Keyword And Ignore Error     Click Element     //div[@id="toggle_buses" and not(contains(@class,'active'))]
    ${numberOfBuses}     Get Element Count    //div[starts-with(@id,"bus_")]
    ${numberOfBuses}    Evaluate     $numberOfBuses+1
    FOR    ${index}    IN RANGE     1    ${numberOfBuses}
        ${busRating}     Get Text       (//li[@class='appendRight10']//span[contains(text(),'.')])[${index}]
        Append To List     ${allBusRating}    ${busRating}
    END
    Sort List    ${allBusRating}
    Log    ${allBusRating}

    ${last_element}    Get From List    ${allBusRating}     -1
    Log    ${last_element}

Get Top Rated Bus    
    Run Keyword And Ignore Error     Click Element     //div[@id="toggle_buses" and not(contains(@class,'active'))]
    Wait Until Element Is Visible    //div[@class='slick-track']/div[contains(@class,'slick-current')]//div[contains(@style,' display: inline-block')]    10s
    Click Element    //div[@class='slick-track']/div[contains(@class,'slick-current')]//div[contains(@style,' display: inline-block')]
    ${top_rating}    Get Text    //li[@class='appendRight10']//span[contains(text(),'4.')]
    Log  ${top_rating}

Check If Ratings Are Equal
    [Arguments]    ${last_element}    ${top_rating}
    Should Be Equal    ${last_element}    ${top_rating}    


Select drop point
    [Arguments]     ${filterType}     ${filterExactText}
    # take the initial count
    Click Element     toggle_buses
    ${initialCount}    Get Element Count     //div[@class="busCardContainer "]     # maximum bus in search result, no filter applied
    Click Element    //div[contains(text(),'${filterType}')]/../..//span[text()='${filterExactText}']
    Wait Until Element Is Not Visible     //div[@class="busListingContainer"]//p[contains(text(),'found') and contains(text(),'${initialCount}')]
    #wait till its not the previous count or wait till elemnt disappears.
    sleep   3s


Verify drop point
    [Arguments]    ${filtertext}
    run keyword and ignore error     Click Element     //div[@id="toggle_buses" and not(contains(@class,'active'))]
    Wait Until Element Is Visible    //div[@class="busCardContainer "]
    ${numberOfBuscard}     Get Element Count    //div[@class="busCardContainer "]
    ${numberOfBuses}    Evaluate     $numberOfBuscard+1
    FOR    ${index}    IN RANGE     1    ${numberOfBuses}
        Scroll Element Into View     (//div[contains(@class,"busCardFooter")]//span[text()="Pickups & Drops"])[${index}]
        Click Element    (//div[contains(@class,"busCardFooter")]//span[text()="Pickups & Drops"])[${index}]
        sleep    3s
        Element Should Be Visible    //ul[@class="btnSelectBusWithoutRadio"]//span[@title="${filtertext}"]    
        Click Element    (//div[contains(@class,"busCardFooter")]//span[text()="Pickups & Drops"])[${index}]
        # ${count}    Evaluate    ${count}+1
    END
    # Should Be Equal As Numbers    ${numberOfBuscard}    ${finalcount}
    # Should Be Equal    ${numberOfBuscard}    ${count}
    Sleep    3s


Get All Bus Id 

    @{allBusId}    Create List
    Run Keyword And Ignore Error     Click Element     //div[@id="toggle_buses" and not(contains(@class,'active'))]
    ${numberOfBuses}     Get Element Count    //div[starts-with(@id,"bus_")]
    ${numberOfBuses}    Evaluate     $numberOfBuses+1
    FOR    ${index}    IN RANGE     1    ${numberOfBuses}
        ${busId}     Get Element Attribute       (//div[starts-with(@id,"bus_")])[${index}]        id  
        Append To List     ${allBusId}    ${busId}
    END
    Log    ${allBusId}
    RETURN    ${numberOfBuses} 

Verify Seat Type

    [Arguments]    ${numberOfBuses}    ${filterType}     
    Run Keyword And Ignore Error     Click Element     //div[@id="toggle_buses" and not(contains(@class,'active'))]
    ${busesnumber}    Get Element Count   (//div[contains(@id,"bus_")]//div[@class="makeFlex false"]//p[contains(text(),'Sleeper')])
    ${numberOfBuses}    Evaluate     $numberOfBuses-1
    Should Be Equal    ${numberOfBuses}    ${busesnumber}
    Run Keyword And Ignore Error    Click Element     toggle_buses
    Run Keyword And Ignore Error    Click Element    //div[contains(text(),'${filterType}')]/../..//span[contains(@class,"sleeperIconActive")]/following-sibling::span[text()='Sleeper']

    Sleep    5s


Verify Pickups point

    [Arguments]    ${filtertext}
    @{place}    Create List
    Run Keyword And Ignore Error    Click Element    //div[@id="toggle_buses" and not(contains(@class,'active'))]
    Wait Until Element Is Visible    //div[@class="busCardContainer "]
    ${numberOfBuscard}    Get Element Count    //div[@class="busCardContainer "]
    ${numberOfBuses}    Evaluate    $numberOfBuscard + 1
    

    FOR    ${index}    IN RANGE    1    ${numberOfBuses}
        Scroll Element Into View    (//div[contains(@class,"busCardFooter")]//span[text()="Pickups & Drops"])[${index}]
        Click Element    (//div[contains(@class,"busCardFooter")]//span[text()="Pickups & Drops"])[${index}]
        Sleep    3s
        Element Should Be Visible    //ul[@class="btnSelectBusWithoutRadio"]//span[@title="${filtertext}"]
        Run Keyword And Ignore Error    Click Element    (//div[contains(@class,"busCardFooter")]//span[text()="Pickups & Drops"])[${index}]
        
    END

undo filter
    Run Keyword And Ignore Error    Click Element    //span[@class='logoContainer']//a[@class='chMmtLogo']
    Wait Until Element Is Visible    //nav//li[@class="menu_Buses"]    5s

Toggle Fastest up Sorting and validate
    [Arguments]    ${ascOrder}
    run keyword and ignore error     Click Element     //div[@id="toggle_buses" and not(contains(@class,'active'))]
    Click Element    //div[@class="makeFlex hrtlCenter"]//li[contains(text(), 'Fastest')]
    Wait Until Buses Are Loaded
    @{durationsofKsrtc}       Get Bus Durations of KSRTC       
    Log    :${durationsofKsrtc} 
    @{durationsofPrivate}       Get Bus Durations of Private     
    Log    :${durationsofPrivate} 
    @{firstDurations}    Join Lists Using Create Lists    ${durationsofKsrtc}    ${durationsofPrivate}  
    Log   Current list: ${firstDurations}
    Validate Durations Sorted    ${firstDurations}   order=${ascOrder}

Toggle Fastest down Sorting and Validate

    [Arguments]    ${dscOrder}
    run keyword and ignore error     Click Element     //div[@id="toggle_buses" and not(contains(@class,'active'))]
    Click Element    //div[@class="makeFlex hrtlCenter"]//li[contains(text(), 'Fastest')]
    Wait Until Buses Are Loaded
    @{durationsofKsrtc}       Get Bus Durations of KSRTC       
    Log    :${durationsofKsrtc} 
    @{durationsofPrivate}       Get Bus Durations of Private     
    Log    :${durationsofPrivate} 
    @{secondDurations}    Join Lists Using Create Lists    ${durationsofKsrtc}    ${durationsofPrivate} 
    Validate Durations Sorted   ${secondDurations}  order=${dscOrder}

Wait Until Buses Are Loaded
    Wait Until Element Is Not Visible    //div[@class="loader"]    timeout=20s
    Wait Until Element Is Visible        //div[@class="busCardContainer "]//div[contains(@class,"makeFlex false")][1]    timeout=20s
    Wait Until Page Contains Element    //div[contains(@class,'secondaryTxt')]    timeout=20s

Get Bus Durations of KSRTC  
    ${durationsofKsrtc}    Create List
    Wait Until Element Is Visible  //p[contains(text(),"KSRTC")]/ancestor::div[@class='makeFlex false']//div[@class='font14 secondaryTxt']
    ${numberOfBuses}     Get Element Count    //p[contains(text(),"KSRTC")]/ancestor::div[@class='makeFlex false']//div[@class='font14 secondaryTxt']
    ${numberOfBuses}    Evaluate     $numberOfBuses+1
    FOR    ${index}    IN RANGE    1    ${numberOfBuses}
        ${durationText}    Get Text    (//p[contains(text(),"KSRTC")]/ancestor::div[@class='makeFlex false']//div[@class='font14 secondaryTxt'])[${index}]
        ${hours}    Set Variable    0
        ${minutes}  Set Variable    0
        ${hoursText}   Evaluate    '''${durationText}'''.split("hrs")[0].strip()
        ${hours}   Convert To Integer    ${hoursText}
        ${minutesText}    Evaluate    '''${durationText}'''.split("hrs")[-1].split("mins")[0].strip()
        ${minutes}      Convert To Integer    ${minutesText}
        ${totalDuration}    Evaluate    (${hours}*60) + ${minutes} 
        Append To List    ${durationsofKsrtc}    ${totalDuration}
    END
    Log    KSRTC Durations: ${durationsofKsrtc}
    [RETURN]     ${durationsofKsrtc}

Get Bus Durations of Private
    ${durationsofPrivate}    Create List
    Wait Until Element Is Visible      //div[@class="rtcEnd"]/following-sibling::div[@class='busCardContainer ']//div[@class="font14 secondaryTxt"]
    ${numberOfBuses}     Get Element Count    //div[@class="rtcEnd"]/following-sibling::div[@class='busCardContainer ']//div[@class="font14 secondaryTxt"]
    ${numberOfBuses}    Evaluate     $numberOfBuses+1
    FOR    ${index}    IN RANGE    1    ${numberOfBuses}
        ${durationText}    Get Text    (//div[@class="rtcEnd"]/following-sibling::div[@class='busCardContainer ']//div[@class="font14 secondaryTxt"])[${index}]
        ${hours}    Set Variable    0
        ${minutes}  Set Variable    0
        ${hoursText}   Evaluate    '''${durationText}'''.split("hrs")[0].strip()
        ${hours}   Convert To Integer    ${hoursText}
        ${minutesText}    Evaluate    '''${durationText}'''.split("hrs")[-1].split("mins")[0].strip()
        ${minutes}      Convert To Integer    ${minutesText}
        ${totalDuration}    Evaluate    (${hours}*60) + ${minutes} 
        Append To List    ${durationsofPrivate}    ${totalDuration}
    END
    Log    Private Durations: ${durationsofPrivate}
    [RETURN]    ${durationsofPrivate}

Join Lists Using Create Lists
    [Arguments]    ${durationsofKsrtc}    ${durationsofPrivate}
    Log    ${durationsofKsrtc}  
    Log    ${durationsofPrivate}
    ${AllBusDuration}=   Create List    ${durationsofKsrtc}   ${durationsofPrivate}
    Log     ${AllBusDuration}   
    Log     ${AllBusDuration[0]}
    Log   ${AllBusDuration[1]}
    [RETURN]     ${AllBusDuration}

Validate Durations Sorted 
    [Arguments]    ${AllBusDuration}     ${order}=${None}
    Log  Durations: ${AllBusDuration}
    ${sortedDurationsFinal}     Copy List     ${AllBusDuration}
    Sort List       ${sortedDurationsFinal[0]}   
    Log      ${sortedDurationsFinal[0]} 
    Sort List       ${sortedDurationsFinal[1]}   
    Log      ${sortedDurationsFinal[1]} 
    Log  ${sortedDurationsFinal}
    Run Keyword If         '${order}' == 'descending'     Reverse List     ${sortedDurationsFinal[0]}
    Run Keyword If        '${order}' == 'descending'     Reverse List    ${sortedDurationsFinal[1]} 
    Should Be Equal    ${sortedDurationsFinal}     ${AllBusDuration}
    Log      ${sortedDurationsFinal[0]} 
    Log  ${sortedDurationsFinal[1]} 
    Log   Sorted Durations: ${sortedDurationsFinal}
Undo
    Click Element     toggle_buses
    Click Element    //div[@class="makeFlex hrtlCenter"]//li[contains(text(), 'Relevance')]

Click Cheapest Button And Verify
    
    Click Element    //li[contains(text(),'Cheapest')]
    ${class}=    Get Element Attribute    //li[contains(text(),'Cheapest')]    class
    Should Contain    ${class}    activeItem    "Cheapest button should be active"

Click Another Sort Button And Verify
    Click Element     //div[@class="makeFlex hrtlCenter"]//li[contains(text(), 'Fastest')]   
    ${class}=    Get Element Attribute    //div[@class="makeFlex hrtlCenter"]//li[contains(text(), 'Cheapest')]   class
    Should Not Contain     ${class}    activeItem    "Cheapest button should not be active"

   



Select Filters
    [Arguments]     ${filterType}     ${filterExactText}
    # take the initial count
    Run Keyword And Ignore Error    Click Element     toggle_buses
    ${initialCount}    Get Element Count     //div[@class="busCardContainer "]     # maximum bus in search result, no filter applied
    Click Element    //div[contains(text(),'${filterType}')]/../..//span[text()='${filterExactText}']    
    Run Keyword And Ignore Error    Wait Until Element Is Not Visible     //div[@class="busListingContainer"]//p[contains(text(),'found') and contains(text(),'${initialCount}')]
    #wait till its not the previous count or wait till elemnt disappears.

Clear Filter    
     
    Click Element    locator=//p[contains(@class,'deepskyBlueText')]             
    Wait Until Element Is Visible    //p[contains(@class,'disabledGrey')]    10s
    

Verify Filter time
    [Arguments]    ${filterExactText}    
    @{totaltime}    Create List
    run keyword and ignore error     Click Element     //div[@id="toggle_buses" and not(contains(@class,'active'))]
    ${numberOfBuses}     Get Element Count    //div[starts-with(@id,"bus_")]
    ${numberOfBuses}    Evaluate     $numberOfBuses+1

    FOR    ${index}    IN RANGE     1    ${numberOfBuses}
    ${time}     Get Text       (//div[@class='line-border-top']/..//span[contains(@class,'latoRegular')])[${index}]          # node with id in it, exact 16 matches.
    ${time}    Set Variable    ${time.replace(':','')}    
    Append To List     ${totaltime}    ${time}
    END
    Sort List    ${totaltime}
    Log    Sorted List (Ascending): ${totaltime}
    ${numberOfBuses}    Evaluate     $numberOfBuses-1
    
    IF    '${filterExactText}' == '6 AM to 11 AM'
        FOR    ${index}    IN RANGE    0    ${numberOfBuses}
            IF    "'${totaltime}[${index}]' < 1100 and '${totaltime}[${index}]' > 0559"
                Log    ${totaltime}[${index}] is within the range
            ELSE
                Log    ${totaltime}[${index}] is not within the range
            END
        END
    ELSE IF    '${filterExactText}' == '11 AM to 6 PM'
        FOR    ${index}    IN RANGE    0    ${numberOfBuses}
            IF    "'${totaltime}[${index}]' < 1800 and '${totaltime}[${index}]' >= 1100"
                Log    ${totaltime}[${index}] is within the range
            ELSE
                Log    ${totaltime}[${index}] is not within the range
            END
        END
    ELSE IF    '${filterExactText}' == '6 PM to 11 PM'
        FOR    ${index}    IN RANGE    0    ${numberOfBuses}
            IF    "'${totaltime}[${index}]' < 2300 and '${totaltime}[${index}]' >= 1800"
                Log    ${totaltime}[${index}] is within the range
            ELSE
                Log    ${totaltime}[${index}] is not within the range
            END
        END
    ELSE IF    '${filterExactText}' == '11 PM to 6 AM'
        FOR    ${index}    IN RANGE    0    ${numberOfBuses}
            IF    "'${totaltime}[${index}]' < 0600 and '${totaltime}[${index}]' >= 2300"
                Log    ${totaltime}[${index}] is within the range
            ELSE
                Log    ${totaltime}[${index}] is not within the range
            END
        END  