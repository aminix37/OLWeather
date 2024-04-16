-- Function to fetch weather data for a city using OpenWeatherMap API
local function fetchWeatherData(city)
    local api_key = "ae61b2a7419ec34a40bfd93453acb5c5"
    local url = string.format("http://api.openweathermap.org/data/2.5/weather?q=%s&appid=%s", city, api_key)
    
    -- Execute curl command to fetch data
    local command = string.format('curl -s "%s"', url)
    local handle = io.popen(command)
    local response = handle:read("*a")
    handle:close()
    
    -- Parse JSON response
    local data = {}
    for k, v in response:gmatch('"([^"]+)":%s*"?([^",]-)"?,?') do
        data[k] = tonumber(v) or v
    end
    
    return data
end

-- Function to display weather information
local function displayWeatherInfo(data)
    if data.cod == 200 then
        print("City:", data.name)
        print("Weather:", data.weather[1].description)
        print("Temperature:", data.main.temp, "K")
        print("Pressure:", data.main.pressure, "hPa")
        print("Humidity:", data.main.humidity, "%")
    else
        print("City not found or API request failed.")
    end
end

-- Main function
local function main()
    print("Enter a city name:")
    local city = io.read()
    
    local weatherData = fetchWeatherData(city)
    displayWeatherInfo(weatherData)
end

-- Run the main function
main()
