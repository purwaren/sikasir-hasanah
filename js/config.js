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
    kassaServer[2] = '152.118.31.172';
/**
* Base url
*/
var baseUrl = '/biestro/';
/**
* Row type
* 0 -> not accumulated
* 1 -> automatic accumulated
*/
var rowType = 0;
/**
* Allow more than 1 pramuniaga on 1 transakction
* 0 -> not allowed
* 1 -> allowed
*/
var allowPramu = 0;
/**
* Tulisan default di Display
*/
var defMsg = new Array();
defMsg[0] = 'Welcome To';
defMsg[1] = 'BIESTRO MART';

/**
 * Config for open price
 * false -> close
 * true -> open
 */
var openPrice = false;

/**
 * Discount untuk refund event custom
 */
var discountRefund=20;

/**
 * Setting item length
 * Default 10 digit
 */
var itemLength=32;
