
# coding: utf-8

# In[1]:


import requests_html
import pymongo
import pandas as pd


# In[2]:


session = requests_html.HTMLSession()


# In[3]:


response = session.get('http://www.twse.com.tw/exchangeReport/MI_INDEX?response=json&date=20181029&type=ALL')


# In[4]:


json = response.json()


# In[5]:


df = pd.DataFrame(columns=json['fields5'], data=json['data5'])
df.head(3)


# In[6]:


client = pymongo.MongoClient('localhost', 27017)
db = client['test']
collection = db['stock_py']
collection


# In[7]:


dic = df.to_dict('records')


# In[8]:


collection.insert_many(dic)

