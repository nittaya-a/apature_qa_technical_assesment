*** Keywords ***

Create A Requst Header
    [Arguments]    ${content_type}    ${accept}
    ${request_header}    Create Dictionary       
    Set To Dictionary    ${request_header}    Content-Type=${content_type}    
    Set To Dictionary    ${request_header}    Accept=${accept}
    Set Test Variable    ${request_header}    ${request_header}
    Log                  ${request_header}

Send A Get Request
    [Arguments]    ${alias}    ${host_url}    ${uri}    ${params}=${NONE}    ${disable_warnings}=1    ${status}=Anything
    Create Session       ${alias}    ${host_url}    disable_warnings=${disable_warnings}
    ${response}          Get On Session    alias=${alias}    url=${uri}    params=${params}    expected_status=${status}
    ${response_code}     Set Variable    ${response.status_code}
    Set Test Variable    ${response_code}    ${response_code}
    [Return]             ${response.json()}
    Log                  ${response_code}
    Log                  ${response.json()}

Send A Post Request
    [Arguments]    ${alias}    ${host_url}    ${uri}    ${request_header}    ${request_body}    ${disable_warnings}=1    ${status}=Anything
    Create Session       ${alias}    ${host_url}    disable_warnings=${disable_warnings}
    ${response}          Post On Session    alias=${alias}    url=${uri}    headers=${request_header}    data=${request_body}    expected_status=${status}
    ${response_code}     Set Variable    ${response.status_code}
    Set Test Variable    ${response_code}    ${response_code}
    [Return]             ${response.json()}
    Log                  ${response_code}
    Log                  ${response.json()}

Send A Put Request
    [Arguments]    ${alias}    ${host_url}    ${uri}    ${request_body}    ${disable_warnings}=1    ${status}=Anything
    Create Session       ${alias}    ${host_url}    disable_warnings=${disable_warnings}
    ${response}          Post On Session    alias=${alias}    url=${uri}    data=${request_body}    expected_status=${status}
    ${response_code}     Set Variable    ${response.status_code}
    Set Test Variable    ${response_code}    ${response_code}
    [Return]             ${response.json()}
    Log                  ${response_code}
    Log                  ${response.json()}

Send A Delete Request
    [Arguments]    ${alias}    ${host_url}    ${uri}    ${status}=Anything
    Create Session    ${alias}    ${host_url}    disable_warnings=${disable_warnings}
    ${response}       Delete On Session    alias=${alias}    url=${uri}    expected_status=${status}
    ${response_code}     Set Variable    ${response.status_code}
    Set Test Variable    ${response_code}    ${response_code}
    [Return]             ${response.json()}
    Log                  ${response_code}
    Log                  ${response.json()}

Create A Request Body
    [Arguments]    ${title}=${NONE}    ${price}=${NONE}    ${description}=${NONE}    ${category}=${NONE}    ${image}=${NONE}
    ${request_body}      Create Dictionary
    IF  '${title}' != '${NONE}'
        Set To Dictionary    ${request_body}      title=${title}
    END
    IF  '${price}' != '${NONE}'
        Set To Dictionary    ${request_body}      price=${price}
    END
    IF  '${description}' != '${NONE}'
        Set To Dictionary    ${request_body}      description=${description}
    END
    IF  '${category}' != '${NONE}'
        Set To Dictionary    ${request_body}      category=${category}
    END
    IF  '${image}' != '${NONE}'
        Set To Dictionary    ${request_body}      image=${image}
    END
    ${request_body}      Evaluate           json.dumps(${request_body})    json
    Set Test Variable    ${request_body}    ${request_body}
    Log                  ${request_body}

The HTTP Response Code Should Be 200
    BuiltIn.Should Be Equal As Integers    ${response_code}    200

The HTTP Response Code Should Be 400
    BuiltIn.Should Be Equal As Integers    ${response_code}    400

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
    [Arguments]    ${response_body}    ${expected_title}=${NONE}    ${expected_price}=${NONE}    
    ...            ${expected_description}=${NONE}    ${expected_category}=${NONE}    ${expected_image}=${NONE}
    ${id}                  Set Variable   ${response_body['id']}
    # Log To Console         \n${id}
    Should Not Be Equal    ${id}    ${EMPTY}
    IF  '${expected_title}' != '${NONE}'
        ${title}    Set Variable   ${response_body['title']}
        # Log To Console    \n${title}
        Should Be Equal    ${expected_title}    ${title}
    END
    IF  '${expected_price}' != '${NONE}'
        ${price}           Set Variable   ${response_body['price']}
        # Log To Console     \n${price}
        Should Be Equal    ${expected_price}    ${price}
    END
    IF  '${expected_description}' != '${NONE}'
        ${description}     Set Variable   ${response_body['description']}
        # Log To Console     \n${description}
        Should Be Equal    ${expected_description}    ${description}
    END
    IF  '${expected_category}' != '${NONE}'
        ${category}        Set Variable   ${response_body['category']}
        # Log To Console     \n${category}
        Should Be Equal    ${expected_category}    ${category}
    END
    IF  '${expected_image}' != '${NONE}'
        ${image}           Set Variable   ${response_body['image']}
        # Log To Console     \n${image}
        Should Be Equal    ${expected_image}    ${image}
    END
