*** Settings ***
Resource       ../resources/common_resources.robot
Variables      ../test_data/api_test_data.yaml
Resource       ../keywords/api_keywords.robot

*** Test Cases ***

Validate A Successful Response Code And All Product Information For Get All Products API
    [Tags]     TS01    TS01-TC01    Positive
    ${get_all_products_api_response_body}    Send A Get Request    alias=${get_all_products_api.alias}     host_url=${base_url}
    ...                                      uri=${get_all_products_api.uri}    expected_status=200
    The Response Body Should Contain All Product Information    response_body=${get_all_products_api_response_body}

Validate A Successful Response Code When Inputting A Correct Request Body For Add A New Product API
    [Tags]     TS02    TS02-TC01    Positive
    Create A Requst Header    request_header_file=add_a_new_product_api_request_header.json
    Create A Request Body    request_body_file=add_a_new_product_api_request_body.json
    ${add_a_new_product_api_response_body}    Send A Post Request    alias=${add_a_new_product_api.alias}    host_url=${base_url}    
    ...                                       uri=${add_a_new_product_api.uri}    request_header=${request_header}    
    ...                                       request_body=${request_body}    expected_status=200
    The Response Body Should Contain A New Product Information    actual_response_body=${add_a_new_product_api_response_body}
    ...                                                           expected_response_body_file=add_a_new_product_api_request_body.json

Validate A Successful Response Code When Inputting A Correct Product ID And Correct Request Body For Update A Product API
    [Tags]     TS03    TS03-TC01    Positive
    Create A Requst Header    request_header_file=update_a_new_product_api_request_header.json
    Create A Request Body    request_body_file=update_a_new_product_api_request_body.json
    ${update_a_product_api_response_body}    Send A Put Request    alias=${update_a_product_api.alias}    host_url=${base_url}    
    ...                                      uri=${update_a_product_api.uri}/${update_a_product_api.product_id}    request_header=${request_header}
    ...                                      request_body=${request_body}    expected_status=200
    The Response Body Should Contain The Updated Product Information    actual_response_body=${update_a_product_api_response_body}
    ...                                                                 expected_response_body_file=update_a_new_product_api_expected_response_body.json

Validate A Bad Request Response Code When Inputting An Incorrect Product ID For Update A Product API
    [Tags]     TS03    TS03-TC02    Negative
    Create A Requst Header    request_header_file=update_a_new_product_api_request_header.json
    Create A Request Body    request_body_file=update_a_new_product_api_request_body.json
    ${update_a_product_api_response_body}    Send A Put Request    alias=${update_a_product_api.alias}    host_url=${base_url}    
    ...                                      uri=${update_a_product_api.uri}/${update_a_product_api.incorrect_product_id}    
    ...                                      request_header=${request_header}    request_body=${request_body}    expected_status=400

Validate A Successful Response Code When Inputting A Correct Product ID For For Delete A Product API
    [Tags]     TS04    TS04-TC01    Positive
    Send A Delete Request    alias=${delete_a_product_api.alias}    host_url=${base_url}    
    ...                      uri=${delete_a_product_api.uri}/${delete_a_product_api.product_id}    expected_status=200

Validate A Bad Request Response Code When Inputting An Incorrect Product ID For Delete A Product API
    [Tags]     TS04    TS04-TC02    Negative
    Send A Delete Request    alias=${delete_a_product_api.alias}    host_url=${base_url}    
    ...                      uri=${delete_a_product_api.uri}/${delete_a_product_api.incorrect_product_id}    expected_status=400

Validate A Successful Response Code And All Category Information For Get All Categories API
    [Tags]     TS05    TS05-TC01    Positive
    ${get_all_categories_api_response_body}    Send A Get Request    alias=${get_all_categories_api.alias}    
    ...                                        host_url=${base_url}    uri=${get_all_categories_api.uri}    expected_status=200
    The Response Body Should Contain All Category Information    response_body=${get_all_categories_api_response_body}

Validate A Successful Response Code When Inputting A Correct Value Of Sort For Sort Results API
    [Tags]     TS06    TS06-TC01    Positive
    Set Sort Parameter For Sort Results API    sort=${sort_results_api.sort_by}
    ${sort_results_api_response_body}    Send A Get Request    alias=${sort_results_api.alias}    host_url=${base_url}    
    ...                                  uri=${sort_results_api.uri}    params=${params}    expected_status=200
    The Response Body Should Contain Results Sorted By Sort Value Correctly    response_body=${sort_results_api_response_body}    
    ...                                                                        sort_value=${sort_results_api.sort_by}