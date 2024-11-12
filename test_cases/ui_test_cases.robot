*** Settings ***
Library        SeleniumLibrary
Resource       ../resources/common_resources.robot
Resource       ../resources/ui_config.robot
Resource       ../resources/ui_locators.robot
Variables      ../test_data/ui_test_data.yaml
Resource       ../keywords/ui_keywords.robot

*** Test Cases ***

Verify the items, price, quantity, and total when checkout with the correct first name, last name, and postal code
    [Setup]    Create Test Case ID Folder
    [Tags]     TS07    TS07-TC01    Positive
    Open A Web Browser And Navigate To Source Demo URL    url=${source_demo_url}    browser=${web_browser}    step=1
    Log In A Source Demo Website                          username=${username}    password=${password}    step=2                     
    Add Products To The Cart                              products=${product_list}    step=3
    Click Cart Button On The Top Right Of The Screen      step=4
    