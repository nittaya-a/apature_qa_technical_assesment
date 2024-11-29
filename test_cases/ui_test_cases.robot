*** Settings ***
Library          SeleniumLibrary
Library          ListenerLibrary
Resource         ../resources/common_resources.robot
Resource         ../resources/ui_config.robot
Resource         ../resources/ui_locators.robot
Variables        ../test_data/ui_test_data.yaml
Resource         ../keywords/ui_keywords.robot
Test Teardown    Run Keyword If Test Failed    Capture Page Screenshot In Case Fail On Website 

*** Test Cases ***

Checkout Successful
    [Template]    Checkout Successful
    # Username     Password       Product List         First Name       Last Name       Postal Code        Test Case ID
    ${username}    ${password}    ${product_list}      ${first_name}    ${last_name}     ${postal_code}    TS07-TC01

Checkout Unsuccessful
    [Template]    Checkout Unsuccessful  
    # Username     Password       Product List         First Name       Last Name       Postal Code       Expected Error Parametor    Test Case ID
    ${username}    ${password}    ${product_list}      ${EMPTY}         ${last_name}    ${postal_code}    First Name                  TS07-TC02
    ${username}    ${password}    ${product_list}      ${first_name}    ${EMPTY}        ${postal_code}    Last Name                   TS07-TC03
    ${username}    ${password}    ${product_list}      ${first_name}    ${last_name}    ${EMPTY}          Postal Code                 TS07-TC04