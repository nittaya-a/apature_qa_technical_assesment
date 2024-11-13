# Running Aperture QA Technical Assesment Script Instruction

### `Required List`<br><br>
1. Visual Studio Code
2. Python
3. Chrome driver (or other web browsers driver)
4. Install required robot framework libraries from requirements.txt file by this command:<br>
   
   ```
   pip3 install -r .\requirements.txt
   ```
### `Steps`<br><br>
1. Set configuration for website<br>

   1.1 Go to (your file location)/aperture_qa_technical_assesment/resources/ui_config.robot

   1.2 Change ${web_browser} value on then save
   - Headless mode: headlesschrome
   - Normal mode: googlechrome

2. Execute the automation script

   ```
   # Execute all test cases for API testing test cases
   robot -d test_result/api ./test_cases/api_test_cases.robot
   
   # Execute all test cases for UI testing test cases
   robot -d test_result/ui ./test_cases/ui_test_cases.robot

   # Execute parallel both API testing and API testing suites
   pabot -d test_result ./test_cases

3. See a test result report and log from
   
   3.1 Individual Execution:
   + API testing: (your file location)/aperture_qa_technical_assesment/test_result/api
    + UI testing: (your file location)/aperture_qa_technical_assesment/test_result/ui
   3.2 Parallel Execution: (your file location)/aperture_qa_technical_assesment/test_result

4. See test result screenshots for UI testing from (your file location)/aperture_qa_technical_assesment/test_result/ui/screenshots
