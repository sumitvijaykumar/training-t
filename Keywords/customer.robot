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

