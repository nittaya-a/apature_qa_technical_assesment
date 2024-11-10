*** Settings ***
Resource       ../resources/common_resources.robot
Variables      ../test_data/api_test_data.yaml
Resource       ../keywords/api_keywords.robot

*** Test Cases ***

Verify A Successful Response Code And All Product Information
    [Tags]     TS01    TS01-TC01    Positive
    ${get_all_products_api_response_body}    Send A Get Request    alias=${get_all_products_api.alias}    
    ...                                      host_url=${base_url}   uri=${get_all_products_api.uri}
    The HTTP Response Code Should Be 200
    The Response Body Should Contain All Product Information    response_body=${get_all_products_api_response_body}

Verify A Successful Response Code When Inputting A Correct Request Body
    [Tags]     TS02    TS02-TC01    Positive
    Create A Requst Header    content_type=${add_a_new_product_api.content_type}    accept=${add_a_new_product_api.accept}
    Create A Request Body    title=${add_a_new_product_api.request_body.title}    price=${add_a_new_product_api.request_body.price}
    ...                      description=${add_a_new_product_api.request_body.description}    category=${add_a_new_product_api.request_body.category}    
    ...                      image=${add_a_new_product_api.request_body.image}
    ${update_a_product_api_response_body}    Send A Post Request    alias=${add_a_new_product_api.alias}    host_url=${base_url}    
    ...                                      uri=${add_a_new_product_api.uri}    request_header=${request_header}    
    ...                                      request_body=${request_body}
    The HTTP Response Code Should Be 200
    The Response Body Should Contain A New Product Information    response_body=${update_a_product_api_response_body}    
    ...                                                           expected_title=${add_a_new_product_api.request_body.title}  
    ...                                                           expected_price=${add_a_new_product_api.request_body.price}  
    ...                                                           expected_description=${add_a_new_product_api.request_body.description}  
    ...                                                           expected_category=${add_a_new_product_api.request_body.category}  
    ...                                                           expected_image=${add_a_new_product_api.request_body.image}
    