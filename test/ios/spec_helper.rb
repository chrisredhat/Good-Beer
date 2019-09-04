require 'rubygems'
require 'appium_lib'

RSpec.configure do |config|
  
  def desired_caps(device_name, udid, version, port)
    opts = {
      caps: {
        platformName: 'iOS',
        automationName: 'XCUITest',
        app: "../../platforms/ios/build/emulator/Good-Beers.app",
        deviceName: device_name,
        udid: udid,
        platformVersion: version,
        wdaLocalPort: port
      },
      appium_lib: {
        wait: 60
      }
    }
  end


  config.before(:all) do

    devices = [
      {:code => "iPhone7_12.1", :name => "iPhone 7", :version => "12.1", :udid => "auto" },
      {:code => "iPhone8_11.2", :name => "iPhone 8", :version => "11.2", :udid => "auto" }
    ]

    @drivers = Hash.new
 
    devices.each_with_index do |device, index|
        puts "Start Driver - #{device[:code]}"
        driver = Appium::Driver.new(desired_caps(device[:name], device[:udid], device[:version] ,6000+index), false).start_driver
        driver.manage.timeouts.implicit_wait = 5
        @drivers.store("#{device[:code]}", driver)
        puts
    end
  end
     
  config.after(:all) do
    puts "Stop Driver"
    @drivers.each do |name, driver|
      puts "Stop #{name}"
      driver.quit
    end
  end

end


 
