*** Settings ***
Library           AppiumLibrary


*** Variables ***
${REMOTE_URL}     http://localhost:4723/wd/hub
${PLATFORM_NAME_ANDROID}    Android
${DEVICE_NAME_ANDROID}    Nexus
${APP_ANDROID}    ${CURDIR}${/}app${/}ApiDemos-debug.apk
${AUTOMATION_NAME}    appium
${User}               foo@example.com
${Password}           hellojaa
${Text_Pass_short}    This password is too short
${EMPTY}                    

*** Test Cases ***
#Case 1
Login alert short password
    Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME_ANDROID}    deviceName=${DEVICE_NAME_ANDROID}    app=${APP_ANDROID}    automationName=${AUTOMATION_NAME}
    input text             id=email          test@gmail.com
    input text             id=password       test
    Click Element          id=email_sign_in_button
    Wait Until Page Contains Element    id=contentPanel   
    #Element Should Contain Text        xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.support.v7.widget.LinearLayoutCompat/android.widget.FrameLayout/android.widget.ScrollView/android.widget.LinearLayout/android.widget.TextView        ${Text_Pass_short}
    Element Should Contain Text     xpath=//*[@text='This password is too short']      ${Text_Pass_short}
    Capture Page Screenshot      case1.png
    Sleep                        5
    Close All Applications

#Case 2
Login alert Not Put User&Password
    Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME_ANDROID}    deviceName=${DEVICE_NAME_ANDROID}    app=${APP_ANDROID}    automationName=${AUTOMATION_NAME}
    input text             id=email          ${EMPTY}
    input text             id=password       ${EMPTY}
    Click Element          id=email_sign_in_button      
    Wait Until Page Contains Element    id=contentPanel 
    Element Should Contain Text        xpath=//*[@text='This field is required']         	This field is required
    Capture Page Screenshot      case2.png
    Sleep                        5
    Close All Applications
	
  #Case 3
Login alert Wrong user&password
    Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME_ANDROID}    deviceName=${DEVICE_NAME_ANDROID}    app=${APP_ANDROID}    automationName=${AUTOMATION_NAME}
    input text             id=email          ${User}
    input text             id=password       helloja
    Click Element          id=email_sign_in_button       
    Wait Until Page Contains Element    id=contentPanel 
    Element Should Contain Text        xpath=//*[@text='Please check email or password.']     	Please check email or password.
    Capture Page Screenshot      case3.png
    Sleep                        5
    Close All Applications


#Case 4
Login succeful
    Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME_ANDROID}    deviceName=${DEVICE_NAME_ANDROID}    app=${APP_ANDROID}    automationName=${AUTOMATION_NAME}
    # AppiumLibrary.Click Element    //android.widget.TextView[@text='Preference']
    # AppiumLibrary.Click Element    //android.widget.TextView[@text='3. Preference dependencies']
    input text             id=email          ${User}
    input text             id=password       ${Password}
    Click Element          id=email_sign_in_button
    Wait Until Page Contains      	Hello foo@example.com     timeout=None      error=None
    Capture Page Screenshot      case4.png
    Sleep                  5
    Close All Applications

