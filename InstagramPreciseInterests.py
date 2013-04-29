#!/usr/bin/python
# initialize a set of front end table with new design
# ./xxx.py get  
# ./xxx.py check
import sys
import os
import MySQLdb
import string
import pp
import time
import InstagramConfiguration
import random

config = InstagramConfiguration.config()

def getImageURL(flag=0):
  query = "SELECT media_id, link3_std FROM %s WHERE update_label='%s' LIMIT %s" %(config.media_table,str(flag),config.read_lim)
  try:
    cursor3.execute(query)
  except:
    print "error reading media table" 
  rows = cursor3.fetchall()
  return rows

def wgetImage(row):
  mid = str(row[0])
  url = str(row[1])
  img_path = config.file_path + mid + ".jpg"
  if not os.path.isfile(img_path):
    os.system("wget %s -O %s" %(url,img_path))
    query = "UPDATE %s SET update_label=1 WHERE media_id='%s'" %(config.media_table, mid)
    try:
      cursor3.execute(query)
    except:
      print "error updating media table"

def checkNullImg(row):
  mid = str(row[0])
  url = str(row[1])
  img_path = config.file_path + mid + ".jpg"
  try:
    if os.path.getsize(img_path) < 10: # then we redownload
      os.system("wget %s -O %s" %(url,img_path))
  except:
    print "can't get size"
if __name__ == '__main__':
  while True:
      try:
          db3 = MySQLdb.connect(host=config.db_host_3, port=config.db_port_3, user=config.db_user_3, passwd=config.db_passwd_3)
          cursor3 = db3.cursor()
          break
      except:
          print "cannot connect the frontend db!"
          time.sleep(1)  

  random.seed()
  try:
    option = str(sys.argv[1])
  except:
    option = 'get'

  if (option == 'get'):
    inputs = getImageURL(0)
    for row in inputs:
      wgetImage(row)
      time.sleep(random.random())
  else:
    i = 0
    inputs = getImageURL(1)
    for row in inputs:
      wgetImage(row)
      checkNullImg(row)
      i = i + 1
    print str(i) + " files fixed"

  cursor3.close()
  db3.close()