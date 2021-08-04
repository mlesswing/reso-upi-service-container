# RESO UPI Service Container 
### Copyright 2019-2021 Lesswing, LLC. 

---

## Table of Contents

- [Introduction](#introduction)
- [Installation](#installation)
- [Container Operations](#container-operations)
  - [Build](#build-or-rebuild-the-container) 
  - [Start and Stop](#starting-and-stopping-the-container) 
  - [Monitor](#monitor-the-container)
  - [Cleanup](#removing-the-container)
- [API Methods](#api-methods)
  - [API Documentation](#api-documentation)
  - [Build a UPI](#build-a-upi)
  - [Parse a UPI](#parse-a-upi)
  - [Discover UPI Information](#discover-upi-information)
  - [Get Build Version](#get-build-version)
- [Notes](#notes)

---

## Introduction

This is a container-based service for the [RESO UPI (Universal Property Identifier)](https://www.reso.org/upi-workgroup/).  It 
can create or validate a RESO UPI using a RESTful API.  It can also be used to discover 
information about states, counties, and towns from text-based hints.  

The container is preconfigured with the following properties:

Property | Description | Setting 
:--- | :--- | :---
host | IP Address of the server | "0.0.0.0"
name | Used for Docker commands | reso-upi-service-container
port | Port serviced by the server | 8081
withTLS | Server is secure (HTTPS) | false
&nbsp;

 
The container is not configured to support TLS requests and is intended for internal use, not
as a publically-available service.

---

## Installation

The Docker container service must be installed on the computer that the API Service container
will be installed on.  There are many guides on the internet that discuss Docker installation
and a good place to start would be the [installation tools](https://docs.docker.com/get-docker)
provided by the distributor.  

The following script can be used to install the API Server as a container-based application 
once Docker is installed.

```sh
> ./scripts/build_container.sh 
```

---

## Container Operations

Scripts located in the `scripts` directory of the distribution can simplify Docker use.  

- build_maintainer_container.sh 
- build_reso_container.sh 
- monitor_container.sh 
- start_container.sh 
- stop_container.sh 
- teardown_container.sh 

The scripts were developed using a [bash shell](https://www.gnu.org/software/bash/).  Refer to
the script code for details regarding Docker invocation.

### Build or Rebuild the Container 

Containers are built from images stored in a repository.  This package is available through
a RESO repository as well as a repository operated by the maintainer.  The versions published
by the maintainer are for development and may contain unstable versions.

This builds and starts the container from an image in the RESO repository:

```sh
> ./scripts/build_reso_container.sh 
```

This builds and starts the container from an image in the repository provided by the maintainer:

```sh
> ./scripts/build_maintainer_container.sh 
```

### Starting and Stopping the Container 

Once build, a container can be started with the follwing:

```sh
> ./scripts/start_container.sh 
```

The container can be stopped with the following:

```sh
> ./scripts/stop_container.sh 
```

You should only build the container once, and then use the start and stop 
processes to control the container.

### Monitor the Container 

To see a running output of the logs for the container, execute the following:

```sh
> docker logs -f reso-upi-service-container
```

To see a snapshot of the logs for the container, execute the following:

```sh
> docker logs reso-upi-service-container
```

### Removing the Container

This cleans up the docker environment:

```sh
> ./scripts/remove_container.sh 
```

### View the Container 

The following command allows you to see the containers that are running.
 
```sh
> docker ps -a
```

### Log into a Container 

If you need to log into the service container, use the following command.  

```sh
> docker exec -it reso-upi-service-container /bin/bash
```

---
# API Methods 

The examples in this section use scripts to perform the described operations.  The
scripts were developed using a [bash shell](https://www.gnu.org/software/bash/)
and the [curl](https://curl.se/) command line tool.

Refer to the script code for details regarding API invocation.  

### API Documentation 

The API is documented in the [API Document](./documents/api.html) file.

### Build a UPI 

The service can build a UPI from either six or seven pieces of information.  The
six element version uses the following data items.  Examples of the information
that is required is presented in parenthesis::


- Country (US)
- FIPS Code (50013)
- Subcounnty Code (50650)
- Parcel Identifier (666777888)
- Property Type (R)
- Subproperty(N)

The service uses FIPS information for the U.S, from the 
[US Census Bureau](https://www.census.gov/library/reference/code-lists/ansi.html).

The seven element version of the API seperates the FIPS code into state and
county identifiers.  These parameters are:

- Country (US)
- State Abbreviation (VT)
- County FIPS Code (013)
- Subcounnty Code (50650)
- Parcel Identifier (666777888)
- Property Type (R)
- Subproperty(N)

The service uses two letter abbreviations for states and provinces in the US, Canada, 
and Mexico comes from the 
[Hierarchical administrative subdivision codes (HASC)](http://www.statoids.com/umx.html) 
extensions to [ISO 3166](https://www.iso.org/iso-3166-country-codes.html).  The two letter 
abbreviation is not unique across countires.  The two letter abbreviation should always be 
used with the country code to gaurantee uniqueness.  An example would be US-AL for Alabama 
or MX-MX for Estado De M&egrave;xico.  The API resuires both parameters when asking for 
a list of states or provinces. 

The following script demonstrates building a UPI with bot sets of inputs.  Each form uses
the `/upi/build` API method:
 
```sh
> ./scripts/build_upi.sh     
============
 RESO UPI Service

 API Method: upi/build
============

Sending to API Server at: http://localhost:8081
---
Scenario #1: parse a upi with seperate state and county
---
{"success":true,"upi":"US-50013-50650-666777888-R-N"}
---
Scenario #2: parse a upi with fips
---
{"success":true,"upi":"US-50013-50650-666777888-R-N"}
```

### Parse a UPI 

The following script demonstrates parsing a UPI with the `/upi/parse` method.

```sh
./scripts/parse_upi.sh 
============
 RESO UPI Service

 API Method: upi/parse
============

Sending to API Server at: http://localhost:8081
---
Scenario #1: parse a upi
---
Parcing UPI US-50013-50650-666777888-R-N
{"county_code":"013","county_name":"Grand Isle County","country_code":"US","country_name":"United States","fips":"50013","parcel":"666777888","property_type":"Real Property","property_type_code":"R","state_abbreviation":"VT","state_code":"50","state_name":"Vermont","subcounty_code":"50650","subcounty_name":"North Hero town","subproperty_code":"N","subproperty_name":"N/A","upi":"US-50013-50650-666777888-R-N"}
```
 
### Discover UPI Information 

The `Discover` capability can be useful when constructing parameters for building UPIs
because it creates codes that can be used to build UPIs.

If you use the name of an area (such as a county or town) to discover UPI information, 
the service will look for matches across all states, counties, and subcounties.  Each result
contains codes that can be used to build a UPI.  Only one of the results si what you 
were looking for.

The structure of each hint includes fields for the country_code, fips_code, and 
subcountry_code of the candidate hint.  Here is an example of one of the hints received when 
searching for "Kane".
 
```sh
{
...
{"country_code":"US","fips_code":"17089","subcounty_code":"60365","hint_description":"Level=County, State=IL, County=Kane County, Subcounty=Plato township"},
...
}
```
The country_code, fips_code, and subcountry_code for the hint is received as well as 
a field named 'hint_descriotion`.  The hint_descriotion indicates that the match "Kane"
occurred on the county level.  The system matched the stored county name of 
"Kane County".

The following script demonstrates discovering UPI information with the `/upi/discover` method.

```sh
./scripts/discover.sh                 
============
 RESO UPI Service

 API Method: upi/discover
============

Sending to API Server at: http://localhost:8081
---
Scenario #1: Return geographic hints API Server
---
Retreiving hints for: Kane
[{"country_code":"US","fips_code":"17061","subcounty_code":"38882","hint_description":"Level=Subcounty, State=IL, County=Greene County, Subcounty=Kane township"},{"country_code":"US","fips_code":"17089","subcounty_code":"03025","hint_description":"Level=County, State=IL, County=Kane County, Subcounty=Aurora township"},{"country_code":"US","fips_code":"17089","subcounty_code":"04091","hint_description":"Level=County, State=IL, County=Kane County, Subcounty=Batavia township"},{"country_code":"US","fips_code":"17089","subcounty_code":"05989","hint_description":"Level=County, State=IL, County=Kane County, Subcounty=Big Rock township"},{"country_code":"US","fips_code":"17089","subcounty_code":"06262","hint_description":"Level=County, State=IL, County=Kane County, Subcounty=Blackberry township"},{"country_code":"US","fips_code":"17089","subcounty_code":"09772","hint_description":"Level=County, State=IL, County=Kane County, Subcounty=Burlington township"},{"country_code":"US","fips_code":"17089","subcounty_code":"10903","hint_description":"Level=County, State=IL, County=Kane County, Subcounty=Campton township"},{"country_code":"US","fips_code":"17089","subcounty_code":"21046","hint_description":"Level=County, State=IL, County=Kane County, Subcounty=Dundee township"},{"country_code":"US","fips_code":"17089","subcounty_code":"23087","hint_description":"Level=County, State=IL, County=Kane County, Subcounty=Elgin township"},{"country_code":"US","fips_code":"17089","subcounty_code":"28885","hint_description":"Level=County, State=IL, County=Kane County, Subcounty=Geneva township"},{"country_code":"US","fips_code":"17089","subcounty_code":"32538","hint_description":"Level=County, State=IL, County=Kane County, Subcounty=Hampshire township"},{"country_code":"US","fips_code":"17089","subcounty_code":"38908","hint_description":"Level=County, State=IL, County=Kane County, Subcounty=Kaneville township"},{"country_code":"US","fips_code":"17089","subcounty_code":"38908","hint_description":"Level=Subcounty, State=IL, County=Kane County, Subcounty=Kaneville township"},{"country_code":"US","fips_code":"17089","subcounty_code":"60365","hint_description":"Level=County, State=IL, County=Kane County, Subcounty=Plato township"},{"country_code":"US","fips_code":"17089","subcounty_code":"66430","hint_description":"Level=County, State=IL, County=Kane County, Subcounty=Rutland township"},{"country_code":"US","fips_code":"17089","subcounty_code":"66716","hint_description":"Level=County, State=IL, County=Kane County, Subcounty=St. Charles township"},{"country_code":"US","fips_code":"17089","subcounty_code":"73404","hint_description":"Level=County, State=IL, County=Kane County, Subcounty=Sugar Grove township"},{"country_code":"US","fips_code":"17089","subcounty_code":"78188","hint_description":"Level=County, State=IL, County=Kane County, Subcounty=Virgil township"},{"country_code":"US","fips_code":"19011","subcounty_code":"92289","hint_description":"Level=Subcounty, State=IA, County=Benton County, Subcounty=Kane township"},{"country_code":"US","fips_code":"19155","subcounty_code":"92292","hint_description":"Level=Subcounty, State=IA, County=Pottawattamie County, Subcounty=Kane township"},{"country_code":"US","fips_code":"27069","subcounty_code":"60646","hint_description":"Level=Subcounty, State=MN, County=Kittson County, Subcounty=Skane township"},{"country_code":"US","fips_code":"36067","subcounty_code":"67521","hint_description":"Level=Subcounty, State=NY, County=Onondaga County, Subcounty=Skaneateles town"},{"country_code":"US","fips_code":"38009","subcounty_code":"41300","hint_description":"Level=Subcounty, State=ND, County=Bottineau County, Subcounty=Kane township"},{"country_code":"US","fips_code":"42083","subcounty_code":"38688","hint_description":"Level=Subcounty, State=PA, County=McKean County, Subcounty=Kane borough"},{"country_code":"US","fips_code":"49025","subcounty_code":"91591","hint_description":"Level=County, State=UT, County=Kane County, Subcounty=Kanab CCD"},{"country_code":"US","fips_code":"49025","subcounty_code":"92494","hint_description":"Level=County, State=UT, County=Kane County, Subcounty=Orderville CCD"},{"country_code":"US","fips_code":"53063","subcounty_code":"90048","hint_description":"Level=County, State=WA, County=Spokane County, Subcounty=Airway Heights CCD"},{"country_code":"US","fips_code":"53063","subcounty_code":"90056","hint_description":"Level=County, State=WA, County=Spokane County, Subcounty=Amber-Cheney South CCD"},{"country_code":"US","fips_code":"53063","subcounty_code":"90552","hint_description":"Level=County, State=WA, County=Spokane County, Subcounty=Cheney-Medical Lake CCD"},{"country_code":"US","fips_code":"53063","subcounty_code":"90640","hint_description":"Level=County, State=WA, County=Spokane County, Subcounty=Colbert CCD"},{"country_code":"US","fips_code":"53063","subcounty_code":"90880","hint_description":"Level=County, State=WA, County=Spokane County, Subcounty=Deer Park CCD"},{"country_code":"US","fips_code":"53063","subcounty_code":"91616","hint_description":"Level=County, State=WA, County=Spokane County, Subcounty=Liberty Lake CCD"},{"country_code":"US","fips_code":"53063","subcounty_code":"92080","hint_description":"Level=County, State=WA, County=Spokane County, Subcounty=Mount Spokane CCD"},{"country_code":"US","fips_code":"53063","subcounty_code":"92080","hint_description":"Level=Subcounty, State=WA, County=Spokane County, Subcounty=Mount Spokane CCD"},{"country_code":"US","fips_code":"53063","subcounty_code":"92816","hint_description":"Level=County, State=WA, County=Spokane County, Subcounty=Rockford CCD"},{"country_code":"US","fips_code":"53063","subcounty_code":"93200","hint_description":"Level=County, State=WA, County=Spokane County, Subcounty=Spokane CCD"},{"country_code":"US","fips_code":"53063","subcounty_code":"93200","hint_description":"Level=Subcounty, State=WA, County=Spokane County, Subcounty=Spokane CCD"},{"country_code":"US","fips_code":"53063","subcounty_code":"93224","hint_description":"Level=County, State=WA, County=Spokane County, Subcounty=Spokane South CCD"},{"country_code":"US","fips_code":"53063","subcounty_code":"93224","hint_description":"Level=Subcounty, State=WA, County=Spokane County, Subcounty=Spokane South CCD"},{"country_code":"US","fips_code":"53063","subcounty_code":"93584","hint_description":"Level=County, State=WA, County=Spokane County, Subcounty=Valleyford CCD"},{"country_code":"US","fips_code":"53065","subcounty_code":"93216","hint_description":"Level=Subcounty, State=WA, County=Stevens County, Subcounty=Spokane Reservation CCD"}]

---
Scenario #2: Return geographic hints API Server
---
Retreiving hints for: Charleston
[{"country_code":"US","fips_code":"17029","subcounty_code":"12580","hint_description":"Level=Subcounty, State=IL, County=Coles County, Subcounty=Charleston township"},{"country_code":"US","fips_code":"19111","subcounty_code":"90647","hint_description":"Level=Subcounty, State=IA, County=Lee County, Subcounty=Charleston township"},{"country_code":"US","fips_code":"20201","subcounty_code":"12625","hint_description":"Level=Subcounty, State=KS, County=Washington County, Subcounty=Charleston township"},{"country_code":"US","fips_code":"23019","subcounty_code":"12105","hint_description":"Level=Subcounty, State=ME, County=Penobscot County, Subcounty=Charleston town"},{"country_code":"US","fips_code":"26077","subcounty_code":"14720","hint_description":"Level=Subcounty, State=MI, County=Kalamazoo County, Subcounty=Charleston township"},{"country_code":"US","fips_code":"36057","subcounty_code":"13816","hint_description":"Level=Subcounty, State=NY, County=Montgomery County, Subcounty=Charleston town"},{"country_code":"US","fips_code":"37173","subcounty_code":"90624","hint_description":"Level=Subcounty, State=NC, County=Swain County, Subcounty=Charleston township"},{"country_code":"US","fips_code":"42117","subcounty_code":"12728","hint_description":"Level=Subcounty, State=PA, County=Tioga County, Subcounty=Charleston township"},{"country_code":"US","fips_code":"45019","subcounty_code":"90570","hint_description":"Level=County, State=SC, County=Charleston County, Subcounty=Charleston Central CCD"},{"country_code":"US","fips_code":"45019","subcounty_code":"90570","hint_description":"Level=Subcounty, State=SC, County=Charleston County, Subcounty=Charleston Central CCD"},{"country_code":"US","fips_code":"45019","subcounty_code":"90988","hint_description":"Level=County, State=SC, County=Charleston County, Subcounty=Edisto Island CCD"},{"country_code":"US","fips_code":"45019","subcounty_code":"91664","hint_description":"Level=County, State=SC, County=Charleston County, Subcounty=James Island CCD"},{"country_code":"US","fips_code":"45019","subcounty_code":"91703","hint_description":"Level=County, State=SC, County=Charleston County, Subcounty=Johns Island CCD"},{"country_code":"US","fips_code":"45019","subcounty_code":"91761","hint_description":"Level=County, State=SC, County=Charleston County, Subcounty=Kiawah Island-Seabrook Island CCD"},{"country_code":"US","fips_code":"45019","subcounty_code":"92080","hint_description":"Level=County, State=SC, County=Charleston County, Subcounty=McClellanville CCD"},{"country_code":"US","fips_code":"45019","subcounty_code":"92301","hint_description":"Level=County, State=SC, County=Charleston County, Subcounty=Mount Pleasant CCD"},{"country_code":"US","fips_code":"45019","subcounty_code":"92424","hint_description":"Level=County, State=SC, County=Charleston County, Subcounty=North Charleston CCD"},{"country_code":"US","fips_code":"45019","subcounty_code":"92424","hint_description":"Level=Subcounty, State=SC, County=Charleston County, Subcounty=North Charleston CCD"},{"country_code":"US","fips_code":"45019","subcounty_code":"92771","hint_description":"Level=County, State=SC, County=Charleston County, Subcounty=Ravenel-Hollywood CCD"},{"country_code":"US","fips_code":"45019","subcounty_code":"93549","hint_description":"Level=County, State=SC, County=Charleston County, Subcounty=Wadmalaw Island CCD"},{"country_code":"US","fips_code":"45019","subcounty_code":"93646","hint_description":"Level=County, State=SC, County=Charleston County, Subcounty=West Ashley CCD"},{"country_code":"US","fips_code":"50019","subcounty_code":"13150","hint_description":"Level=Subcounty, State=VT, County=Orleans County, Subcounty=Charleston town"}]

```
 
### Get Build Version 

Execute the following script to return all facts.

```sh
> ./scripts/getServerVersion.sh
============
 RESO UPI Service

 API Method: version
============

Sending to API Server at: http://localhost:8081
---
Scenario #1: Return the build version of the API Server
---
Version: build20210317

```
---

## Notes 

---

