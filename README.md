---
title: Homework 7 - Creating a resume database
author: Bryan Soerjanto
date: last-modified
format:
    html:
        theme: cosmo
        toc: true
        embed-resources: true
        code-copy: true
---

GITHUB URL:  https://github.com/cmsc-vcu/cmsc508-fa2023-hw7-soerjantobj

```{python}
#| eval: true
#| echo: false
import os
import sys
import pandas as pd
from tabulate import tabulate
from dotenv import load_dotenv
from sqlalchemy import create_engine, text
from sqlalchemy.exc import OperationalError, ProgrammingError
from IPython.display import display, Markdown
```
```{python}
#| eval: true
#| echo: false

# modify config_map to reflect credentials needed by this program
config_map = {
    'user':'CMSC508_USER',
    'password':'CMSC508_PASSWORD',
    'host':'CMSC508_HOST',
    'database':'HW7_DB_NAME'
}
# load and store credentials
load_dotenv()
config = {}
for key in config_map.keys():
    config[key] = os.getenv(config_map[key])
flag = False
for param in config.keys():
    if config[param] is None:
        flag = True
        print(f"Missing {config_map[param]} in .env file")
#if flag:
#    sys.exit(1)
```
```{python}
#| eval: true
#| echo: false

# build a sqlalchemy engine string
engine_uri = f"mysql+pymysql://{config['user']}:{config['password']}@{config['host']}/{config['database']}"

# create a database connection.  THIS IS THE ACTUAL CONNECTION!
try:
    cnx = create_engine(engine_uri)
except ArgumentError as e:
    print(f"create_engine: Argument Error: {e}")
    #sys.exit(1)
except NoSuchModuleError as e:
    print(f"create_engine: No Such Module Error: {e}")
    #sys.exit(1)
except Exception as e:
    print(f"create_engine: An error occurred: {e}")
    #sys.exit(1)
```
```{python}
#| echo: false
#| eval: true

# Do a quick test of the connection and trap the errors better!
try:
    databases = pd.read_sql("show databases",cnx)
except ImportError as e:
    print(f"Error: {e}")
except OperationalError as e:
    print(f"Database/SQL Error:\n{str(e)}\n")
except ProgrammingError as e:
    print(f"Programming Error:\n{str(e)}\n")
except Exception as e:
    print(f"An error occurred:\n{str(e)}\n")

```

## Overview and description

(briefly describe the project and the database)

## Crows-foot diagram

People have skills and roles. The table peopleskills and peopleroles serves to reduce redundancy

```{mermaid}
%%| echo: false
erDiagram
    people ||--o{ skills : have
    people ||--o{ roles : have

    people{
        PRI people_id
        varchar people_first_name
        varchar people_last_name
        varchar email
        varchar linkedin_url
        varchar headshot_url
        varchar discord_handle
        varchar brief_bio
        date date_joined
    }

    skills{
        PRI id
        varchar name
        varchar description
        varchar tag
        varchar url
        date time_commitment 
    }
    roles{
        PRI id
        varchar name
        int sort_priority
    }

    peopleskills{
        PRI id
        int skills_id 
        int people_id
        date date_acquired
    }

    peopleroles{
        PRI id
        int people_id
        int role_id
        date date_assigned
    }
```

## Examples of data in the database

For the people, skills, and roles tables, provide a description of each table and it's contents. Then provide a listing of the entire table.

### People table

The *people* table contains elements that describe ... 

Below is a list of data in the *people* table.

```{python}
#| echo: false
#| eval: true
sql = f"""
select * from people;
"""
## Add code to list roles table here
try:
    df = pd.read_sql(sql,cnx)
    df
except Exception as e:
    message = str(e)
    print(f"An error occurred:\n\n{message}\n\nIgnoring and moving on.")
    df = pd.DataFrame()
df
```

### Skills table

The *skills* table contains elements that describe ... 

Below is a list of data in the *skills* table.

```{python}
#| echo: false
#| eval: true
sql = f"""
select * from skills;
"""
## Add code to list roles table here
try:
    df = pd.read_sql(sql,cnx)
    df
except Exception as e:
    message = str(e)
    print(f"An error occurred:\n\n{message}\n\nIgnoring and moving on.")
    df = pd.DataFrame()
df
```

### Roles table

The *roles* table contains elements that describe ... 

Below is a list of data in the *roles* table.

```{python}
#| echo: false
#| eval: true

## Add code to list roles table here
```


## Sample queries

Let's explore the database!

# List skill names, tags, and descriptions ordered by name

```{python}
sql = f"""
select * from people
"""
```

```{python}
#| echo: false
#| eval: true
try:
    df = pd.read_sql(sql,cnx)
    df
except Exception as e:
    message = str(e)
    print(f"An error occurred:\n\n{message}\n\nIgnoring and moving on.")
    df = pd.DataFrame()
df

```


### List people names and email addresses ordered by last_name

```{python}
sql = f"""
select email, people_last_name, people_first_name
from people
order by people_last_name
"""

try:
    df = pd.read_sql(sql,cnx)
    df
except Exception as e:
    message = str(e)
    print(f"An error occurred:\n\n{message}\n\nIgnoring and moving on.")
    df = pd.DataFrame()
df

```


### List skill names of Person 1
```{python}
sql = f"""
select s.name
from skills s
join peopleskills ps ON s.id = ps.skills_id
join people p on p.people_id = ps.people_id
where p.people_id = 1;
"""

try:
    df = pd.read_sql(sql,cnx)
    df
except Exception as e:
    message = str(e)
    print(f"An error occurred:\n\n{message}\n\nIgnoring and moving on.")
    df = pd.DataFrame()
df

```

### List people names with Skill 6
```{python}
sql = f"""
select people_first_name, people_last_name
from people p
join peopleskills ps on p.people_id = ps.people_id
join skills s on s.id = ps.skills_id
where skills_id = 6
"""

try:
    df = pd.read_sql(sql,cnx)
    df
except Exception as e:
    message = str(e)
    print(f"An error occurred:\n\n{message}\n\nIgnoring and moving on.")
    df = pd.DataFrame()
df

```

### List people with a DEVELOPER role

```{python}
sql = f"""
select *
from people p
join peopleroles pr on p.people_id = pr.people_id
join roles r on pr.role_id = r.id
where r.name = 'Developer'
"""

try:
    df = pd.read_sql(sql,cnx)
    df
except Exception as e:
    message = str(e)
    print(f"An error occurred:\n\n{message}\n\nIgnoring and moving on.")
    df = pd.DataFrame()
df

```

### List names and email addresses of people without skills

```{python}
sql = f"""
select p.people_first_name, p.people_last_name, p.email
from people p
join peopleskills ps on p.people_id = ps.people_id
where ps.skills_id = 0;
"""

try:
    df = pd.read_sql(sql,cnx)
    df
except Exception as e:
    message = str(e)
    print(f"An error occurred:\n\n{message}\n\nIgnoring and moving on.")
    df = pd.DataFrame()
df
```

### List names and tags of unused skills

```{python}
sql = f"""
select name, tag
from skills s
left join peopleskills ps on s.id = ps.skills_id
where ps.people_id IS NULL
"""

try:
    df = pd.read_sql(sql,cnx)
    df
except Exception as e:
    message = str(e)
    print(f"An error occurred:\n\n{message}\n\nIgnoring and moving on.")
    df = pd.DataFrame()
df
```

### List people names and skill names with the BOSS role

```{python}
sql = f"""
select p.people_first_name, p.people_last_name, s.name
from people p
join peopleroles pr on p.people_id = pr.people_id
join roles r on pr.role_id = r.id
left join peopleskills ps on p.people_id = ps.people_id
left join skills s on ps.skills_id = s.id
where r.name = 'Boss'
"""

try:
    df = pd.read_sql(sql,cnx)
    df
except Exception as e:
    message = str(e)
    print(f"An error occurred:\n\n{message}\n\nIgnoring and moving on.")
    df = pd.DataFrame()
df
```

### List ids and names of unused roles

```{python}
sql = f"""
select r.id, r.name
from roles r
left join peopleroles pr on r.id = pr.role_id
where pr.people_id is null
"""

try:
    df = pd.read_sql(sql,cnx)
    df
except Exception as e:
    message = str(e)
    print(f"An error occurred:\n\n{message}\n\nIgnoring and moving on.")
    df = pd.DataFrame()
df
```

## Reflection

(Write a paragraph expressing your thoughts, feelings, and insights about your experience with this assignment.  Pause and breath before writing - I'm trying to encourage critical thinking and self-awareness while allowing you to explore the connections between theory and practice. And yes, delete this paragraph.)