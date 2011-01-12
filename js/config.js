/**
* Screen configuration
* 14 inch 
* 17 inch
*/
var screenConfig = '14';
/**
* Terminal kasir configuration
* Set the ip address based on ip address kassa
*/
var kassaServer = new Array();
    kassaServer[1] = 'localhost';
    kassaServer[2] = 'localhost';
/**
* Base url
*/
var baseUrl = 'http://localhost/sikasir/';
/**
* Row type
* 0 -> not accumulated
* 1 -> automatic accumulated
*/
var rowType = 0
/**
* Allow more than 1 pramuniaga on 1 transakction
* 0 -> not allowed
* 1 -> allowed
*/
var allowPramu = 0;