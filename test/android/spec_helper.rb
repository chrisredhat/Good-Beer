require 'rubygems'
require 'appium_lib'

RSpec.configure do |config|
  
  def desired_caps(device_name, port)
    opts = {
      caps: {
        platformName: 'Android',
        automationName: 'UIAutomator2',
        app: 'app-release.apk',
        fullReset: 'true',
        deviceName: device_name,
        avd: device_name,
        systemPort: port
      },
      appium_lib: {
        wait: 60
      }
    }
  end


  config.before(:all) do

    device_names = [
      'Nexus_S_API_26',
      'Pixel_2_API_26'
    ]
 
    @drivers = Hash.new
 
    device_names.each_with_index do |device_name, index|
        puts "Start Driver -  #{device_name}" 
        driver = Appium::Driver.new(desired_caps(device_name, 5000+index), false).start_driver
        driver.manage.timeouts.implicit_wait = 5
        @drivers.store("#{device_name}", driver)
        puts
    end
  end
     
  config.after(:all) do
    puts "Stop Driver"
    @drivers.each do |name, driver|
#      puts "Uninstall App on #{name}"
#      driver.remove_app('com.technet.demo')

      puts "Stop #{name}"
      driver.quit
    end
  end

end


 
