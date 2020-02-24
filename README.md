# Hack-REST-API-Example

Example of a REST API For Hack Lang using [Hack Router](https://github.com/hhvm/hack-router)

To install HHVM and Hack, see [installation](https://docs.hhvm.com/hhvm/installation/introduction)

## Running The Server

### Install dependencies (Using [Composer](https://getcomposer.org/)):

`composer install` 

### Run:

`hhvm -c config.ini -m server -p 8080`

**NOTE:**
If you are using Linux, you need to edit the configuration file to replace any instance of `/usr/local/etc/hhvm/` with `/etc/hhvm/`

The server will then be running on port 8080

## Routes Included In This Project

`GET /` : returns a message about a get request to the homepage

`POST /` : returns a message about a post request to the homepage

`GET /example/{param}` : returns a message with the param
