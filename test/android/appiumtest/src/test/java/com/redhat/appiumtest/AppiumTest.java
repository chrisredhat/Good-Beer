package com.redhat.appiumtest;

// Junit Test
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

// Appium Service
import io.appium.java_client.service.local.AppiumDriverLocalService;
import io.appium.java_client.service.local.AppiumServerHasNotBeenStartedLocallyException;

// Appium Driver
import org.openqa.selenium.By;
import io.appium.java_client.android.AndroidDriver;

// Appium Session
import org.openqa.selenium.remote.DesiredCapabilities;

import java.util.Hashtable;
import java.util.concurrent.TimeUnit;


// This class is a base which is used to start appium service and driver
public class AppiumTest {
    private static AppiumDriverLocalService service;
    public AndroidDriver driver;

    @Before
    public void startUp() {
        // Start Local Appium Server
        service = AppiumDriverLocalService.buildDefaultService();
        service.start();
        if (service == null || !service.isRunning()) {
            throw new AppiumServerHasNotBeenStartedLocallyException(
                    "An appium server node is not started!");
        }
        else {
            System.out.println("#############\nAppium server started\n#############");
        }

        // Define Appium Session
        DesiredCapabilities capabilities = new DesiredCapabilities();
        capabilities.setCapability("platformName", "Android");
        capabilities.setCapability("automationName", "UIAutomator2");
        capabilities.setCapability("fullReset", "true");
        capabilities.setCapability("deviceName", "Nexus_S_API_26");
        capabilities.setCapability("avd","Nexus_S_API_26");
        capabilities.setCapability("app", "/tmp/app-release.apk");
        capabilities.setCapability("systemPort", "5000");

        // Start Driver
        driver = new AndroidDriver(service.getUrl(), capabilities);
        driver.manage().timeouts().implicitlyWait(20, TimeUnit.SECONDS);
    }

    @After
    public void shutdown() {
        if (driver != null) {
            System.out.println("#############\nTerminating driver ...\n#############");
            driver.quit();
        }
        if (service != null) {
            System.out.println("#############\nTerminating Appium Service ...\n#############");
            service.stop();
        }
    }

    @Test
    public void tapNavigationBar() {
        System.out.println("Test Case 1 - Tap page icon on navigation bar");

        Hashtable<String, String> navigation = new Hashtable<String, String>();
        navigation.put("About", "tab-t0-3");
        navigation.put("Beer", "tab-t0-1");
        navigation.put("Contact", "tab-t0-2");
        navigation.put("Home", "tab-t0-0");
        System.out.println(navigation);

        for (String page : navigation.keySet()) {
            System.out.println("Go to " + page + " Page");
            driver.findElement(By.xpath("//*[@resource-id=\""+navigation.get(page)+"\"]")).click();
        }

    }
}
