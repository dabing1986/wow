import urllib.request
import os
import logging
import time

# Configure the logging module
logging.basicConfig(filename='log.txt', level=logging.DEBUG,
                    format='%(asctime)s %(levelname)s: %(message)s')

url = "http://down.wowdata.top/AuctionHouseDataDump/zh_CN/AppData.lua"

# Path of the file to write the data to
filename = "D:/World of Warcraft/_classic_/Interface/AddOns/TradeSkillMaster_AppHelper/AppData.lua"

# Wait time in seconds before retrieving the data
wait_time = 10

# Wait for the specified time before retrieving the data
logging.info('Waiting for %d seconds', wait_time)
time.sleep(wait_time)

# Retrieve data from the website
logging.info('Retrieving data from %s', url)
data = urllib.request.urlopen(url).read().decode()

# Write the data to the file
logging.info('Writing data to file %s', filename)
with open(filename, "w", encoding="utf-8") as file:
    file.write(data)

# Print a message to indicate that the script has completed
logging.info('Data written to file %s', filename)
print("Data written to file:", filename)
