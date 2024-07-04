*** Comments ***


*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary
Library    OperatingSystem

*** Variables ***
${BROWSER}        Chrome
${URL}            https://dev-wordpress.bayarind.id/

*** Test Cases ***
Create va bca
    Open Browser To Landing Page
    Add to cart    479
    View cart
    Checkout
    Fill Billing Details
    Confirm order
    Get VA number
    # Welcome Page Should Be Open
    # [Teardown]    Close Browser

*** Keywords ***
Open Browser To Landing Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Title Should Be    Merchant Store

Add to cart
    [Arguments]    ${product_id}
    Click Element    xpath: //a[@data-product_id="${product_id}"]
    Sleep    3s
    Page Should Contain    View cart

View cart
    Click Element    xpath: //a[@href="https://dev-wordpress.bayarind.id/cart/"]
    Title Should Be    Cart – Merchant Store

Checkout
    Click Element    xpath: //a[@href="https://dev-wordpress.bayarind.id/checkout/"]
    Title Should Be    Checkout – Merchant Store

Fill Billing Details
    Input Text    billing_first_name    QA
    Input Text    billing_last_name    test
    Input Text    billing_address_1    Poncol Indah
    Input Text    billing_city    Cireundeu
    Input Text    billing_postcode    64352
    Input Text    billing_phone    08912451347
    Input Text    billing_email    qa@gmail.com
    Click Element    xpath://li[@class="wc_payment_method payment_method_bcava"]
    Click Button    place_order
    Sleep    3s

Confirm order
    Page Should Contain    Pay for order
    Scroll Element Into View    xpath://*[contains(text(), 'Confirm order')]
    Click Element    xpath://*[contains(text(), 'Confirm order')]
    Sleep    2s
    Title Should Be    BCA Virtual Account Payment – Merchant Store

Get VA number
    # ${va_no} = Get Text    //b[normalize-space()='3811800000001515']
    Capture Page Screenshot    va_number.png

# Submit Credentials
#     Click Button    login_button

# Welcome Page Should Be Open
#     Title Should Be    Welcome Page