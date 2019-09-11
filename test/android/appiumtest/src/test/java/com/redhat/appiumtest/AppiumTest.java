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
    private static Hashtable<String, AndroidDriver> drivers = new Hashtable<>();

    private static DesiredCapabilities capabilities(String device, int port) {
        // Define Appium Session
        DesiredCapabilities caps = new DesiredCapabilities();
        caps.setCapability("platformName", "Android");
        caps.setCapability("automationName", "UIAutomator2");
        caps.setCapability("fullReset", true);
        caps.setCapability("deviceName", device);
        caps.setCapability("avd",device);
        caps.setCapability("app", "app-release.apk");
        caps.setCapability("systemPort", port);
        return caps;
    }

    private void startDrivers() {
        String[] devices = {"Nexus_S_API_26", "Pixel_2_API_26"};

        // Start drivers according to number of devices
        for (int i = 0; i < devices.length; i++) {
            drivers.put(devices[i], new AndroidDriver(service.getUrl(), capabilities(devices[i], 5000+i)));
            System.out.println("\nDriver started on device " + devices[i] + "\n");
            drivers.get(devices[i]).manage().timeouts().implicitlyWait(20, TimeUnit.SECONDS);
        }
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
            startDrivers();
        }
    }

    @After
    public void shutdown() {
        // shutdown drivers and Appium service
        if (drivers != null) {
            for (String device : drivers.keySet()) {
                System.out.println("#############\nTerminate driver on device " + device + "\n#############");
                drivers.get(device).quit();
            }
        }
        if (service != null) {
            System.out.println("#############\nTerminating Appium Service ...\n#############");
            service.stop();
        }
    }

    private void tapNavigationBar(String page, String resourceID, String device) {
        System.out.println("\nGo to " + page + " Page on device " + device +"\n");
        // find element by resource id and perform click action
        drivers.get(device).findElement(By.xpath("//*[@resource-id=\"" + resourceID + "\"]")).click();
    }

    @Test
    public void executeNavigationTest() {
        System.out.println("\nTest Case 1 - Tap page icon on navigation bar\n");

        Hashtable<String, String> navigationBar = new Hashtable<>();
        navigationBar.put("About", "abctab-t0-3");
        navigationBar.put("Beer", "tab-t0-1");
        navigationBar.put("Contact", "tab-t0-2");
        navigationBar.put("Home", "tab-t0-0");

        drivers.entrySet()
                .parallelStream()
                .forEach(entry -> {
                    for (String page : navigationBar.keySet()) {
                        tapNavigationBar(page, navigationBar.get(page), entry.getKey());
                    }
                });
    }

    @Test
    public void executeBeerTest() {
        System.out.println("\nTest Case 2 - Go to Beer\n");
        
        drivers.entrySet()
                .parallelStream()
                .forEach(entry -> tapNavigationBar("Beer", "tab-t0-1", entry.getKey()));
    }
}
