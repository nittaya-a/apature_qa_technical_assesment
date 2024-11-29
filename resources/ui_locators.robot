*** Variables ***

# Page: Log in

${log_in_page_user_name_field}                                    xpath://input[@id ='user-name']
${log_in_page_user_password_field}                                xpath://input[@id ='password']
${log_in_page_log_in_button}                                      xpath://input[@id ='login-button']

# Page: Products

${products_page_products_title}                                   xpath://span[text()='Products']
${products_page_shopping_cart_button}                             xpath://a[@class='shopping_cart_link']

# Page: Cart

${cart_page_your_cart_title}                                      xpath://span[text()='Your Cart']
${cart_page_checkout_button}                                      xpath://button[@id='checkout']

# Page: Checkout step 1

${checkout_step_1_page_checkout_your_information_title}           xpath://span[text()='Checkout: Your Information']
${checkout_step_1_page_first_name_field}                          xpath://input[@id='first-name']
${checkout_step_1_page_last_name_field}                           xpath://input[@id='last-name']
${checkout_step_1_page_postal_code_field}                         xpath://input[@id='postal-code']
${checkout_step_1_page_continue_button}                           xpath://input[@id='continue']

# Page: Checkout step 2

${checkout_step_2_page_checkout_overview_title}                   xpath://span[text()='Checkout: Overview']
${checkout_step_2_page_item_total_text}                           xpath://div[@class='summary_subtotal_label']
${checkout_step_2_page_tax_text}                                  xpath://div[@class='summary_tax_label']
${checkout_step_2_page_total_with_tax_text}                       xpath://div[@class='summary_total_label']
${checkout_step_2_page_finish_button}                             xpath://button[@id='finish']

# Page: Checkout complete

${checkout_complete_page_checkout_complete_title}                 xpath://span[text()='Checkout: Complete!']
${checkout_complete_page_thank_you_for_your_order_message}        xpath://h2[text()='Thank you for your order!']

# Common Locators

${common_product_name_locator}                                    xpath://div[text()='(product_name)']
${common_quantity_locator}                                        xpath://div[text()='(product_name)']/../../..//div[text()='(quantity)']
${common_price_locator}                                           xpath://div[text()='(product_name)']/../..//div[@class='inventory_item_price']