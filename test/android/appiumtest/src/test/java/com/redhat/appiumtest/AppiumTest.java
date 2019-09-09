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
    //public static AndroidDriver[] drivers;

    private static DesiredCapabilities capabilities(String device, int port) {
        // Define Appium Session
        DesiredCapabilities caps = new DesiredCapabilities();
        caps.setCapability("platformName", "Android");
        caps.setCapability("automationName", "UIAutomator2");
        caps.setCapability("fullReset", true);
        caps.setCapability("deviceName", device);
        caps.setCapability("avd",device);
        caps.setCapability("app", "/tmp/app-release.apk");
        caps.setCapability("systemPort", port);
        return caps;
    }

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
    }

    @After
    public void shutdown() {
        if (service != null) {
            System.out.println("#############\nTerminating Appium Service ...\n#############");
            service.stop();
        }
    }

    private static Hashtable<String, String> navigationBar() {
        Hashtable<String, String> navigation = new Hashtable<>();
        navigation.put("About", "tab-t0-3");
        navigation.put("Beer", "tab-t0-1");
        navigation.put("Contact", "tab-t0-2");
        navigation.put("Home", "tab-t0-0");
        return navigation;
    }

    private void tapNavigationBar(String device, int port) {
        System.out.println("\nTest Case 1 - Tap page icon on navigation bar\n");
        Hashtable<String, String> navigation = navigationBar();

        // Start Driver
        AndroidDriver driver = new AndroidDriver(service.getUrl(), capabilities(device, port));
        driver.manage().timeouts().implicitlyWait(20, TimeUnit.SECONDS);
        try {
            for (String page : navigation.keySet()) {
                System.out.println("\nGo to " + page + " Page\n");
                driver.findElement(By.xpath("//*[@resource-id=\"" + navigation.get(page) + "\"]")).click();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            System.out.println("#############\nTerminating driver ...\n#############");
            driver.quit();
        }
    }

    @Test
    public void executeTest() {

        Hashtable<String, Integer> devices = new Hashtable<>();
        devices.put("Pixel_2_API_26", 5001);
        devices.put("Nexus_S_API_26", 5000);


        devices.entrySet()
                .parallelStream()
                .forEach(entry -> tapNavigationBar(entry.getKey(), entry.getValue()));
        
        /*
        String[] devices = {"Nexus_S_API_26", "Pixel_2_API_26"};
        for (int i = 0; i < devices.length; i++) {
            tapNavigationBar(devices[i], 5000+i);
        }
         */
    }
}
