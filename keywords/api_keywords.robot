*** Keywords ***

Create A Requst Header
    [Arguments]    ${request_header_file}
    ${request_header}    Get File  ${EXECDIR}/test_data/${request_header_file}
    ${request_header}    Evaluate    json.loads("""${request_header}""")    json
    Set Test Variable    ${request_header}    ${request_header}

Create A Request Body
    [Arguments]    ${request_body_file}
    ${body}              Get File  ${EXECDIR}/test_data/${request_body_file}
    ${body}              Evaluate    json.loads("""${body}""")    json
    Set Test Variable    ${request_body}    ${body}

Send A Get Request
    [Arguments]    ${alias}    ${host_url}    ${uri}    ${expected_status}    ${params}=${NONE}    ${disable_warnings}=1        
    Create Session    ${alias}    ${host_url}    disable_warnings=${disable_warnings}
    ${response}       Get On Session    alias=${alias}    url=${uri}    params=${params}    expected_status=${expected_status}
    Log               ${response.json()}
    [Return]          ${response.json()}
    
Send A Post Request
    [Arguments]    ${alias}    ${host_url}    ${uri}    ${request_header}    ${request_body}    ${expected_status}    ${disable_warnings}=1
    Create Session    ${alias}    ${host_url}    disable_warnings=${disable_warnings}
    ${response}       Post On Session    alias=${alias}    url=${uri}    headers=${request_header}    json=${request_body}    expected_status=${expected_status}
    Log               ${response.json()}
    [Return]          ${response.json()}
    
Send A Put Request
    [Arguments]    ${alias}    ${host_url}    ${uri}    ${request_body}    ${request_header}    ${expected_status}    ${disable_warnings}=1    ${status}=Anything
    Create Session    ${alias}    ${host_url}    disable_warnings=${disable_warnings}
    ${response}       Put On Session    alias=${alias}    url=${uri}    json=${request_body}    headers=${request_header}    expected_status=${expected_status}
    Log               ${response.json()}
    [Return]          ${response.json()}
    
Send A Delete Request
    [Arguments]    ${alias}    ${host_url}    ${uri}    ${expected_status}    ${disable_warnings}=1
    Create Session    ${alias}    ${host_url}    disable_warnings=${disable_warnings}
    ${response}       Delete On Session    alias=${alias}    url=${uri}    expected_status=${expected_status}
    Log               ${response.json()}
    [Return]          ${response.json()}
    

The Response Body Should Contain All Product Information
    [Arguments]    ${response_body}
    ${product_id_list}    Get Value From Json    ${response_body}    $.[*].id
    ${total_product}      Get Length    ${product_id_list}
    Should Be True        ${total_product} > 0
    # Log To Console        \n${total_product}
    FOR  ${index}  IN RANGE  ${0}   ${total_product}
        ${title}               Set Variable   ${response_body[${index}]['title']}
        # Log To Console         \n${title}
        Should Not Be Empty    ${title}
        ${price}               Set Variable   ${response_body[${index}]['price']}
        # Log To Console         \n${price}
        Should Not Be Equal    ${price}    ${EMPTY}
        ${description}         Set Variable   ${response_body[${index}]['description']}
        # Log To Console         \n${description}
        Should Not Be Empty    ${description}
        ${category}            Set Variable   ${response_body[${index}]['category']}
        # Log To Console         \n${category}
        Should Not Be Empty    ${category}
        ${image}               Set Variable   ${response_body[${index}]['image']}
        # Log To Console         \n${image}
        Should Not Be Empty    ${image}
        ${rate}                Set Variable   ${response_body[${index}]['rating']['rate']}
        # Log To Console         \n${rate}
        Should Not Be Equal    ${rate}    ${EMPTY}
        ${count}               Set Variable   ${response_body[${index}]['rating']['count']}
        # Log To Console         \n${count}
        Should Not Be Equal    ${count}    ${EMPTY}
    END

The Response Body Should Contain A New Product Information
    [Arguments]    ${actual_response_body}    ${expected_response_body_file}
    ${expected_response_body}     Get File  ${EXECDIR}/test_data/${expected_response_body_file}
    ${expected_response_body}     Evaluate    json.loads("""${expected_response_body}""")    json
    Should Not Be Equal           ${actual_response_body['id']}               ${EMPTY}
    Should Be Equal               ${expected_response_body['title']}          ${actual_response_body['title']}
    Should Be Equal               ${expected_response_body['price']}          ${actual_response_body['price']}
    Should Be Equal               ${expected_response_body['description']}    ${actual_response_body['description']}
    Should Be Equal               ${expected_response_body['category']}       ${actual_response_body['category']}
    Should Be Equal               ${expected_response_body['image']}          ${actual_response_body['image']}

The Response Body Should Contain The Updated Product Information
    [Arguments]    ${actual_response_body}    ${expected_response_body_file}
    ${expected_response_body}     Get File  ${EXECDIR}/test_data/${expected_response_body_file}
    ${expected_response_body}     Evaluate    json.loads("""${expected_response_body}""")    json
    Should Be Equal               ${expected_response_body['id']}             ${actual_response_body['id']}
    Should Be Equal               ${expected_response_body['title']}          ${actual_response_body['title']}
    Should Be Equal               ${expected_response_body['price']}          ${actual_response_body['price']}
    Should Be Equal               ${expected_response_body['description']}    ${actual_response_body['description']}
    Should Be Equal               ${expected_response_body['category']}       ${actual_response_body['category']}
    Should Be Equal               ${expected_response_body['image']}          ${actual_response_body['image']}

The Response Body Should Contain All Category Information
    [Arguments]    ${response_body}
    ${total_categories}    Get Length    ${response_body}
    # Log To Console         \ntotal_categories: ${total_categories}
    FOR  ${index}  IN RANGE  0  ${total_categories}
        Should Not Be Empty    ${response_body}[${index}]
    END

Set Sort Parameter For Sort Results API
    [Arguments]    ${sort}
    ${sort_param}        Create Dictionary
    Set To Dictionary    ${sort_param}        sort=${sort}
    Set Test Variable    ${params}            ${sort_param}
    # Log To Console       \n${params}

The Response Body Should Contain Results Sorted By Sort Value Correctly
    [Arguments]    ${response_body}    ${sort_value}
    ${product_id_list}    Get Value From Json    ${response_body}    $.[*].id
    ${total_product}      Get Length    ${product_id_list}
    FOR  ${index}  IN RANGE  0  ${total_product} - 1
        IF  '${sort_value}' == 'desc'
            ${previous_id}    Set Variable    ${response_body[${index}]['id']}
            # Log To Console    \n${previous_id}
            ${next_id}        Set Variable    ${response_body[${index} + 1]['id']}
            # Log To Console    \n${next_id}
            Should Be True    ${previous_id} > ${next_id}
        ELSE
            ${previous_id}    Set Variable    ${response_body[${index}]['id']}
            # Log To Console    \n${previous_id}
            ${next_id}        Set Variable    ${response_body[${index} + 1]['id']}
            # Log To Console    \n${next_id}
            Should Be True    ${previous_id} < ${next_id}
        END
    END