*** Keywords ***
Search bus
    [Arguments]   ${fromcity}   ${tocity}     ${date}=today's date
    ${day}    ${month}    Split String    ${date}    ${SPACE}
 
    Wait Until Element Is Visible   //li[@class='menu_Buses']
    Click Element  //li[@class='menu_Buses']
    Wait Until Element Is Visible   fromCity      10s
    Click Element    fromCity
    Wait Until Element Is Visible  //input[contains(@placeholder,'From')]
    Input Text   //input[contains(@placeholder,'From')]  ${fromcity}
    Wait Until Element Is Visible  //div[contains(@class,'autosuggest')]//span[contains(text(),'${fromcity},')]
    Click Element  //div[contains(@class,'autosuggest')]//span[contains(text(),'${fromcity},')]
 
    Run Keyword And Ignore Error  Click Element    toCity
    Wait Until Element Is Visible  //input[contains(@placeholder,'To')]
    Input Text   //input[contains(@placeholder,'To')]  ${tocity}
    Wait Until Element Is Visible  //div[contains(@class,'autosuggest')]//span[contains(text(),'(${tocity})')]
    Click Element  //div[contains(@class, 'autosuggest')]//span[contains(text(),'${toCity},') or contains(text(),'(${toCity}),')]
 
    Run Keyword And Ignore Error  Click Element    travelDate
    ${datelocator}  Set Variable If   "${date}"=="today's date"
    ...    //div[@class='DayPicker-Month']//div[@aria-selected='true']
    ...    //div[contains(text(),${month})]/ancestor::div[@class='DayPicker-Month']//div[contains(text(),${day})]
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
    
    ${sorted_private_prices}    Copy List    ${allPrivatePrices}
    Sort List    ${sorted_private_prices}
    

    @{combined_sorted_prices}    Create List
    FOR    ${price}    IN    @{sorted_ksrtc_prices}
        Append To List    ${combined_sorted_prices}    ${price}
    END
    FOR    ${price}    IN    @{sorted_private_prices}
        Append To List    ${combined_sorted_prices}    ${price}
    END
    
    
    
    
    ${is_sorted_correctly}    Evaluate    ${allBusPrice} == ${combined_sorted_prices}
    
    IF    ${is_sorted_correctly}
        Log    Prices are sorted correctly
    ELSE
        Fail    Prices are not sorted correctly
    END
    
    Log    KSRTC Bus Prices: ${sorted_ksrtc_prices}
    Log    Private Bus Prices: ${sorted_private_prices}
    Log    Original Combined Prices: ${allBusPrice}
    Log    Combined Sorted Prices: ${combined_sorted_prices}
Undo
    Click Element     toggle_buses
    Click Element    //div[@class="makeFlex hrtlCenter"]//li[contains(text(), 'Relevance')]
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
    ${today}    todaydate.today_date
    Log     ${today}
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
        ${busDate}     Get Text       (//span[contains(@class,"latoBlack blackText")]/following-sibling::span[contains(@class,"secondaryTxt")])[${index}]          # node with id in it, exact 16 matches.
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

Verify Busname
    [Arguments]    ${filterType}   ${BUS_NAME} 

    Log    ${allBusName}

    FOR    ${i}    IN    @{allBusName}
    Should Be Equal As Strings     ${BUS_NAME}    ${i}
    END


Initial condition
    [Documentation]  Click on clear to undo my changes
    
    [Arguments]     ${filterType}

    #Click Element     //div[@class="filterContainer"]//p[text()="CLEAR ALL"]
    Click Element      //div[text()="${filterType}"]/following-sibling::div[text()="CLEAR"]



Clear Filter    ${filter}
     
    Click Element    //p[contains(@class,'deepskyBlueText')]             
    Wait Until Element Is Visible    //p[contains(@class,'disabledGrey')]    10s

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