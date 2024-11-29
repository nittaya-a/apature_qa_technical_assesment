*** Keywords ***

Remove Test Result Screenshots File In Test Case ID Folder
    ${test_case_folder_exists}    Run Keyword and Return Status    Directory Should Exist    ${EXECDIR}/test_result/ui/screenshots/${test_case_id}
    IF  ${test_case_folder_exists} == ${True}
        Empty Directory    ${EXECDIR}/test_result/ui/screenshots/${test_case_id}
    END
    
Create Test Case ID Folder
    ${test_case_folder_exists}    Run Keyword and Return Status    Directory Should Exist    ${EXECDIR}/test_result/ui/screenshots/${test_case_id}
    IF  ${test_case_folder_exists} == ${False}
        Create Directory    ${EXECDIR}/test_result/ui/screenshots/${test_case_id}
    END
    Set Test Variable    ${test_case_id}    ${test_case_id}

Initialize Running Number
    Set Test Variable    ${running_number}    ${0}

Generate Running Number
    ${running_number}    Evaluate    ${running_number} + 1
    Set Test Variable    ${running_number}    ${running_number}

Capture Page Screenshot Each Test Step 
    ListenerLibrary.Register End Keyword Listener         Generate Running Number
    ListenerLibrary.Register End Keyword Listener         SeleniumLibrary.Capture Page Screenshot 	 filename=${EXECDIR}/test_result/ui/screenshots/${test_case_id}/${running_number} ${test_step}.png

Capture Page Screenshot In Case Fail On Website
    # ${test_case_id}                            Get From List    ${TEST TAGS}    2
    Create Directory                           ${EXECDIR}/test_result/ui/screenshots/${test_case_id}
    SeleniumLibrary.Capture Page Screenshot    filename=${EXECDIR}/test_result/ui/screenshots/${test_case_id}/Fail/fail.png

Open A Web Browser And Navigate To Source Demo URL
    Set Test Variable    ${test_step}    Open A Web Browser And Navigate To Source Demo URL
    SeleniumLibrary.Open Browser    url=${source_demo_url}    browser=${web_browser}
    SeleniumLibrary.Maximize Browser Window
    Capture Page Screenshot Each Test Step

Log In A Source Demo Website
    [Arguments]    ${username}    ${password}
    Set Test Variable                                   ${test_step}                          Log In A Source Demo Website
    SeleniumLibrary.Wait Until Page Contains Element    ${log_in_page_user_name_field}
    SeleniumLibrary.Input Text                          ${log_in_page_user_name_field}        ${username}
    SeleniumLibrary.Input Text                          ${log_in_page_user_password_field}    ${password}
    Capture Page Screenshot Each Test Step
    SeleniumLibrary.Click Element 	                    ${log_in_page_log_in_button}

Add Products To The Cart
    [Arguments]    ${products}
    Set Test Variable    ${test_step}    Add Products To The Cart
    ${total_product}     Get Length      ${products}
    FOR  ${index}  IN RANGE  0  ${total_product}
        SeleniumLibrary.Wait Until Page Contains Element 	 xpath://div[text()='${products}[${index}][product_name]']/../../../div[@class='pricebar']//button[text()='Add to cart']
        SeleniumLibrary.Click Element 	                     xpath://div[text()='${products}[${index}][product_name]']/../../../div[@class='pricebar']//button[text()='Add to cart']
    END
    Capture Page Screenshot Each Test Step

Click Cart Button On The Top Right Of The Screen
    Set Test Variable                                   ${test_step}                             Click Cart Button On The Top Right Of The Screen
    SeleniumLibrary.Wait Until Page Contains Element    ${products_page_shopping_cart_button}
    Capture Page Screenshot Each Test Step
    SeleniumLibrary.Click Element 	                    ${products_page_shopping_cart_button}
    
Click Checkout Button
    Set Test Variable                                   ${test_step}                    Click Checkout Button
    SeleniumLibrary.Wait Until Page Contains Element    ${cart_page_checkout_button}
    Capture Page Screenshot Each Test Step
    SeleniumLibrary.Click Element 	                    ${cart_page_checkout_button}    

Input Your Information On Checkout Step 1 Page
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    Set Test Variable                                   ${test_step}                                 Input Your Information On Checkout Step 1 Page
    SeleniumLibrary.Wait Until Page Contains Element    ${checkout_step_1_page_first_name_field}
    SeleniumLibrary.Input Text                          ${checkout_step_1_page_first_name_field}     ${first_name}
    SeleniumLibrary.Wait Until Page Contains Element    ${checkout_step_1_page_last_name_field}
    SeleniumLibrary.Input Text                          ${checkout_step_1_page_last_name_field}      ${last_name}
    SeleniumLibrary.Wait Until Page Contains Element    ${checkout_step_1_page_postal_code_field}
    SeleniumLibrary.Input Text                          ${checkout_step_1_page_postal_code_field}    ${postal_code}
    Capture Page Screenshot Each Test Step

Click Continue Button
    Set Test Variable                                   ${test_step}                               Click Continue Button
    SeleniumLibrary.Wait Until Page Contains Element    ${checkout_step_1_page_continue_button}
    Capture Page Screenshot Each Test Step
    SeleniumLibrary.Click Element 	                    ${checkout_step_1_page_continue_button}

Validate The Items, Price, And Quantity
    [Arguments]    ${expected_selected_items}
    ${total_item}    Get Length    ${expected_selected_items}
    FOR  ${index}  IN RANGE  0  ${total_item}        
        ${product_name}                                      Set Variable    ${expected_selected_items}[${index}][product_name]
        # Log To Console                                       \n${product_name}
        ${quantity}                                          Set Variable    ${expected_selected_items}[${index}][quantity]
        ${quantity}                                          Convert To String    ${quantity}
        ${expected_price}                                    Set Variable    ${expected_selected_items}[${index}][price]
        # Log To Console                                       \n${expected_price}
        ${product_name_locator}                              Replace String    ${common_product_name_locator}    (product_name)    ${product_name}
        SeleniumLibrary.Wait Until Page Contains Element 	 ${product_name_locator}
        SeleniumLibrary.Page Should Contain Element 	     ${product_name_locator}
        ${quantity_locator}                                  Replace String    ${common_quantity_locator}    (product_name)    ${product_name}
        ${quantity_locator}                                  Replace String    ${quantity_locator}    (quantity)    ${quantity}
        SeleniumLibrary.Page Should Contain Element 	     ${quantity_locator}
        # Log To Console                                       \n${product_name}
        ${price_locator}                                     Replace String    ${common_price_locator}    (product_name)    ${product_name}
        ${actual_price}                                      SeleniumLibrary.Get Text    ${price_locator}
        # Log To Console                                       \n${actual_price}
        Should Be Equal                                      $${expected_selected_items}[${index}][price]    ${actual_price}
    END

Validate The Items, Price, And Quantity On The Cart Page
    [Arguments]    ${expected_selected_items}
    Set Test Variable                          ${test_step}    Validate The Items, Price, And Quantity On The Cart Page
    Validate The Items, Price, And Quantity    expected_selected_items=${expected_selected_items}
    Capture Page Screenshot Each Test Step

Calculate Total Without Tax
    [Arguments]    ${expected_selected_items}
    ${total_without_tax}        Set Variable    ${0}
    ${total_item}               Get Length    ${expected_selected_items}
    FOR  ${index}  IN RANGE  0  ${total_item}
        ${quantity}             Set Variable    ${expected_selected_items}[${index}][quantity]
        ${price}                Set Variable    ${expected_selected_items}[${index}][price]
        ${item_price}           Evaluate    ${price} * ${quantity}
        # Log To Console          \n${item_price}
        ${total_without_tax}    Evaluate    ${total_without_tax} + ${item_price}
        # Log To Console          \n${total_without_tax}
    END
    Set Test Variable    ${total_without_tax}    ${total_without_tax}

Validate The Items, Price, Quantity, Total, And Total With Tax On The Checkout Step 2 Page
    [Arguments]    ${expected_selected_items}
    Set Test Variable           ${test_step}    Validate The Items, Price, Quantity, Total, And Total With Tax On The Checkout Step 2 Page
    Validate The Items, Price, And Quantity    expected_selected_items=${expected_selected_items}
    Calculate Total Without Tax                expected_selected_items=${expected_selected_items}
    ${actual_item_total}                       SeleniumLibrary.Get Text    ${checkout_step_2_page_item_total_text}
    # Log To Console                             \n${actual_item_total}
    Should Be Equal                            ${actual_item_total}    Item total: $${total_without_tax}
    ${tax}                                     SeleniumLibrary.Get Text    ${checkout_step_2_page_tax_text}
    ${tax}                                     Replace String    ${tax}    Tax: $    ${EMPTY}
    # Log To Console                             \n${tax}
    ${total_with_tax}                          Evaluate    ${total_without_tax} + ${tax}
    ${total_with_tax}                          Convert To Number    ${total_with_tax}    2
    # Log To Console                             \n${total_with_tax}
    ${actual_total_with_tax}                   SeleniumLibrary.Get Text    ${checkout_step_2_page_total_with_tax_text}
    # Log To Console                             \n${actual_total_with_tax}
    Should Be Equal                            ${actual_total_with_tax}    Total: $${total_with_tax}
    Capture Page Screenshot Each Test Step

Click Finish Button
    Set Test Variable                                   ${test_step}                             Click Finish Button
    SeleniumLibrary.Scroll Element Into View 	        ${checkout_step_2_page_finish_button}
    SeleniumLibrary.Wait Until Page Contains Element    ${checkout_step_2_page_finish_button}
    Capture Page Screenshot Each Test Step
    SeleniumLibrary.Click Element 	                    ${checkout_step_2_page_finish_button}
    
Validate The Checkout Successful Message
    Set Test Variable                                   ${test_step}                                                  Validate The Checkout Successful Message
    SeleniumLibrary.Wait Until Page Contains Element    ${checkout_complete_page_checkout_complete_title}
    SeleniumLibrary.Page Should Contain Element         ${checkout_complete_page_checkout_complete_title}
    SeleniumLibrary.Page Should Contain Element         ${checkout_complete_page_thank_you_for_your_order_message}
    Capture Page Screenshot Each Test Step

Validate The Error Message On The Checkout Step 1 Page
    [Arguments]    ${expected_error_parameter}
    Set Test Variable                                   ${test_step}                                                           Validate The Error Message On The Checkout Step 1 Page
    Capture Page Screenshot Each Test Step
    SeleniumLibrary.Wait Until Page Contains Element    xpath://h3[text()='Error: ${expected_error_parameter} is required']
    SeleniumLibrary.Page Should Contain Element         xpath://h3[text()='Error: ${expected_error_parameter} is required']

Prepare Test Case ID Folder To Capture Page Screenshots
    Initialize Running Number
    Remove Test Result Screenshots File In Test Case ID Folder
    Create Test Case ID Folder

# Test Template

Checkout Successful
    [Arguments]    ${username}    ${password}    ${product_list}
    ...            ${first_name}     ${last_name}    ${postal_code}    ${test_case_id}
    Set Test Variable    ${test_case_id}    ${test_case_id}
    Prepare Test Case ID Folder To Capture Page Screenshots
    Open A Web Browser And Navigate To Source Demo URL
    Log In A Source Demo Website    username=${username}    password=${password}    
    Add Products To The Cart    products=${product_list}
    Click Cart Button On The Top Right Of The Screen
    Validate The Items, Price, And Quantity On The Cart Page    expected_selected_items=${product_list}
    Click Checkout Button                                             
    Input Your Information On Checkout Step 1 Page    first_name=${first_name}    last_name=${last_name}    postal_code=${postal_code}
    Click Continue Button
    Validate The Items, Price, Quantity, Total, And Total With Tax On The Checkout Step 2 Page    expected_selected_items=${product_list}
    Click Finish Button                                               
    Validate The Checkout Successful Message
    SeleniumLibrary.Close Browser

Checkout Unsuccessful
    [Arguments]    ${username}    ${password}    ${product_list}
    ...            ${first_name}     ${last_name}    ${postal_code}
    ...            ${expected_error_parameter}    ${test_case_id}
    Set Test Variable    ${test_case_id}    ${test_case_id}
    Prepare Test Case ID Folder To Capture Page Screenshots
    Open A Web Browser And Navigate To Source Demo URL
    Log In A Source Demo Website    username=${username}    password=${password}  
    Add Products To The Cart    products=${product_list}
    Click Cart Button On The Top Right Of The Screen
    Validate The Items, Price, And Quantity On The Cart Page        expected_selected_items=${product_list}
    Click Checkout Button
    Input Your Information On Checkout Step 1 Page    first_name=${first_name}    last_name=${last_name}    postal_code=${postal_code}
    Click Continue Button
    Validate The Error Message On The Checkout Step 1 Page    expected_error_parameter=${expected_error_parameter}
    SeleniumLibrary.Close Browser 