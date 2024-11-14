# Running Aperture QA Technical Assesment Script Instruction

### `Prerequisites`<br><br>
1. Visual Studio Code
2. Python
3. Chrome driver (or other web browsers driver)
4. Install required robot framework libraries from requirements.txt file by this command:<br>
   
   ```
   pip3 install -r .\requirements.txt
   ```
### `Steps`<br><br>
1. Choose your web browser<br>

   1.1 Go to (your cloned repository location)/aperture_qa_technical_assesment/resources/ui_config.robot

   1.2 The default browser is Chrome. If needed change ${web_browser} value to your preferred web browser then save
   

   |Browser|Value|
   | --- | --- |
   | Firefox | firefox, ff |
   | Headless Firefox | headlessfirefox |
   | Headless Chrome | headlesschrome |
   | Internet Explorer | internetexplorer, ie |
   | Edge | edge |
   | Safari | safari |

2. Execute the automation test scripts

   ```
   # Execute all API test cases
   robot -d test_result/api ./test_cases/api_test_cases.robot
   
   # Execute all UI test cases
   robot -d test_result/ui ./test_cases/ui_test_cases.robot

   # Parallel execute all API and UI test cases
   pabot -d test_result ./test_cases
   ```

3. See the test result reports and logs in
   
   3.1 For individual executions:
   + API testing: (your cloned repository location)/aperture_qa_technical_assesment/test_result/api
    + UI testing: (your cloned repository location)/aperture_qa_technical_assesment/test_result/ui

   3.2 For parallel executions: (your cloned repository location)/aperture_qa_technical_assesment/test_result

4. See the test result screenshots for UI test cases in (your cloned repository location)/aperture_qa_technical_assesment/test_result/ui/screenshots
