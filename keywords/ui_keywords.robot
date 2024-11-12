*** Keywords ***

Create Test Case ID Folder
    ${test_case_id}    Get From List    ${TEST TAGS}    2
    ${test_case_folder_exists}    Run Keyword and Return Status    Directory Should Exist    ${EXECDIR}/test_result/ui/screenshots/${test_case_id}
    IF  ${test_case_folder_exists} == ${False}
        Create Directory    ${EXECDIR}/test_result/ui/screenshots/${test_case_id}
    END
    Set Test Variable    ${test_case_id}    ${test_case_id}

Open A Web Browser And Navigate To Source Demo URL
    [Arguments]    ${url}    ${browser}    ${step}=${NONE}
    SeleniumLibrary.Open Browser    url=${url}    browser=${browser}
    SeleniumLibrary.Maximize Browser Window
    IF  '${step}' != '${NONE}'
        SeleniumLibrary.Capture Page Screenshot 	 filename=${EXECDIR}/test_result/ui/screenshots/${test_case_id}/${step} Open A Web Browser And Navigate To Source Demo URL.png
    END

Log In A Source Demo Website
    [Arguments]    ${username}    ${password}    ${step}=${NONE}
    SeleniumLibrary.Wait Until Page Contains Element    ${log_in_page_user_name_field}
    SeleniumLibrary.Input Text    ${log_in_page_user_name_field}        ${username}
    SeleniumLibrary.Input Text    ${log_in_page_user_password_field}    ${password}
    IF  '${step}' != '${NONE}'
        SeleniumLibrary.Capture Page Screenshot 	 filename=${EXECDIR}/test_result/ui/screenshots/${test_case_id}/${step} Log In A Source Demo Website.png
    END
    SeleniumLibrary.Click Element 	 ${log_in_page_log_in_button}

Add Products To The Cart
    [Arguments]    ${products}    ${step}=${NONE}
    ${total_product}    Get Length    ${products}
    FOR  ${index}  IN RANGE  0  ${total_product}
        SeleniumLibrary.Wait Until Page Contains Element 	 xpath://div[text()='${products}[${index}][product_name]']/../../../div[@class='pricebar']//button[text()='Add to cart']
        SeleniumLibrary.Click Element 	                     xpath://div[text()='${products}[${index}][product_name]']/../../../div[@class='pricebar']//button[text()='Add to cart']
    END
    IF  '${step}' != '${NONE}'
        SeleniumLibrary.Capture Page Screenshot 	 filename=${EXECDIR}/test_result/ui/screenshots/${test_case_id}/${step} Add Products To The Cart.png
    END

Click Cart Button On The Top Right Of The Screen
    [Arguments]    ${step}=${NONE}
    SeleniumLibrary.Wait Until Page Contains Element    ${products_page_shopping_cart_button}
    SeleniumLibrary.Click Element 	                    ${products_page_shopping_cart_button}
    IF  '${step}' != '${NONE}'
        SeleniumLibrary.Capture Page Screenshot 	 filename=${EXECDIR}/test_result/ui/screenshots/${test_case_id}/${step} Click Cart Button On The Top Right Of The Screen.png
    END