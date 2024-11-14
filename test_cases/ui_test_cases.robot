*** Settings ***
Library        SeleniumLibrary
Resource       ../resources/common_resources.robot
Resource       ../resources/ui_config.robot
Resource       ../resources/ui_locators.robot
Variables      ../test_data/ui_test_data.yaml
Resource       ../keywords/ui_keywords.robot

*** Test Cases ***

Validate The Items, Price, Quantity, And Total When Checkout With The Correct First name, Last name, And Postal code
    [Setup]       Run Keywords    Remove Test Result Screenshots File In Test Case ID Folder    
    ...           AND    Create Test Case ID Folder
    [Tags]        TS07    TS07-TC01    Positive
    [Teardown]    Run Keywords    Run Keyword If Test Failed    Capture Page Screenshot In Case Fail On Website
    ...           AND    SeleniumLibrary.Close Browser    
    Open A Web Browser And Navigate To Source Demo URL                url=${source_demo_url}    browser=${web_browser}    step=1
    Log In A Source Demo Website                                      username=${username}    password=${password}    step=2                     
    Add Products To The Cart                                          products=${product_list}    step=3
    Click Cart Button On The Top Right Of The Screen                  step=4
    Validate The Items, Price, And Quantity On The Cart Page          expected_selected_items=${product_list}    step=5
    Click Checkout Button                                             step=6
    Input Your Information On Checkout Step 1 Page                    first_name=${first_name}    last_name=${last_name}    postal_code=${postal_code}    step=7
    Click Continue Button                                             step=8
    Validate The Items, Price, Quantity, Total, And Total With Tax    expected_selected_items=${product_list}    step=9
    Click Finish Button                                               step=10
    Validate The Checkout Successful Message                          step=11

Validate The Error Message When Checkout By Leaving The First Name Field Empty On The Checkout Step 1 Page
    [Setup]       Run Keywords    Remove Test Result Screenshots File In Test Case ID Folder    
    ...           AND    Create Test Case ID Folder
    [Tags]        TS07    TS07-TC02    Nagative
    [Teardown]    Run Keywords    Run Keyword If Test Failed    Capture Page Screenshot In Case Fail On Website
    ...           AND    SeleniumLibrary.Close Browser 
    Open A Web Browser And Navigate To Source Demo URL              url=${source_demo_url}    browser=${web_browser}    step=1
    Log In A Source Demo Website                                    username=${username}    password=${password}    step=2                     
    Add Products To The Cart                                        products=${product_list}    step=3
    Click Cart Button On The Top Right Of The Screen                step=4
    Validate The Items, Price, And Quantity On The Cart Page        expected_selected_items=${product_list}    step=5
    Click Checkout Button                                           step=6
    Input Your Information On Checkout Step 1 Page                  first_name=${EMPTY}    last_name=${last_name}    postal_code=${postal_code}    step=7
    Click Continue Button                                           step=8
    Validate The Error Message                                      error_message_locator=${checkout_step_1_page_first_name_is_required_error_message}    step=9

Validate The Error Message When Checkout By Leaving The Last Name Field Empty On The Checkout Step 1 Page
    [Setup]       Run Keywords    Remove Test Result Screenshots File In Test Case ID Folder    
    ...           AND    Create Test Case ID Folder
    [Tags]        TS07    TS07-TC03    Nagative
    [Teardown]    Run Keywords    Run Keyword If Test Failed    Capture Page Screenshot In Case Fail On Website
    ...           AND    SeleniumLibrary.Close Browser 
    Open A Web Browser And Navigate To Source Demo URL              url=${source_demo_url}    browser=${web_browser}    step=1
    Log In A Source Demo Website                                    username=${username}    password=${password}    step=2                     
    Add Products To The Cart                                        products=${product_list}    step=3
    Click Cart Button On The Top Right Of The Screen                step=4
    Validate The Items, Price, And Quantity On The Cart Page        expected_selected_items=${product_list}    step=5
    Click Checkout Button                                           step=6
    Input Your Information On Checkout Step 1 Page                  first_name=${first_name}    last_name=${EMPTY}    postal_code=${postal_code}    step=7
    Click Continue Button                                           step=8
    Validate The Error Message                                      error_message_locator=${checkout_step_1_page_last_name_is_required_error_message}    step=9

Validate The Error Message When Checkout By Leaving The Postal Code Field Empty On The Checkout Step 1 Page
    [Setup]       Run Keywords    Remove Test Result Screenshots File In Test Case ID Folder    
    ...           AND    Create Test Case ID Folder
    [Tags]        TS07    TS07-TC04    Nagative
    [Teardown]    Run Keywords    Run Keyword If Test Failed    Capture Page Screenshot In Case Fail On Website
    ...           AND    SeleniumLibrary.Close Browser 
    Open A Web Browser And Navigate To Source Demo URL              url=${source_demo_url}    browser=${web_browser}    step=1
    Log In A Source Demo Website                                    username=${username}    password=${password}    step=2                     
    Add Products To The Cart                                        products=${product_list}    step=3
    Click Cart Button On The Top Right Of The Screen                step=4
    Validate The Items, Price, And Quantity On The Cart Page        expected_selected_items=${product_list}    step=5
    Click Checkout Button                                           step=6
    Input Your Information On Checkout Step 1 Page                  first_name=${first_name}    last_name=${last_name}    postal_code=${EMPTY}    step=7
    Click Continue Button                                           step=8
    Validate The Error Message                                      error_message_locator=${checkout_step_1_page_postal_code_is_required_error_message}    step=9