api_port <- 8000
rit_port <- 9999
rit_key <- 'A7XHB46S'

#* @apiTitle Delta-Hedging API

#* Check RIT Client API Status
#* @param rit_port The RIT Client API Port, default 9999
#* @param rit_key The key for the RIT Client API
#* @get /rit_status
function(rit_port=9999, rit_key) {
    url <- paste0("http://localhost:", as.character(rit_port), "/v1/case")
    tryCatch(
        expr = {
            response <- GET(url, add_headers('X-API-Key' = rit_key), timeout(3))
            if (status_code(response)==200) {
                msg <- "OK"
            }},
        error = function(e){
            msg <- "RIT Client API not ready."
        }
    )
}

#* Get Securities
#* @param rit_port The RIT Client API Port, default 9999
#* @param rit_key The key for the RIT Client API
#* @param ticker Ticker (case-sensitive)
#* @get /position
function(rit_port=9999, rit_key) {
    url <- paste0("http://localhost:", as.character(rit_port), "/v1/securities")
    response <- GET(url, add_headers('X-API-Key' = rit_key), timeout(3))     
    r <- content(response, as="text", encoding="UTF-8")
    securities <- fromJSON(r)
    securities_melt <- jsonlite:::simplify(securities, flatten = TRUE)
    # EXCEL PARAMETERS VS API
    # Position -> position
    # PLUNR -> unrealized
    # PLREL -> realized
    # COST -> vwap
    # BSZ -> bid_size
    # BID -> bid
    # VOLUME -> volume
    # ASK -> ask
    # ASZ -> ask_size
    # TO PARSE JSON, USE JSONLITE
}

# Get TIMEREMAINDER (case ticks_per_period - tick)
#* Case TIMEREMAINDER
#* @param rit_port The RIT Client API Port, default 9999
#* @param rit_key The key for the RIT Client API
#* @get /timeremainder
function(rit_port=9999, rit_key) {
    url <- paste0("http://localhost:", as.character(rit_port), "/v1/case")
    response <- GET(url, add_headers('X-API-Key' = rit_key), timeout(3))
    r <- content(response, as="text", encoding="UTF-8")
    securities <- fromJSON(r)
}


#* Submit Trade
#* @param ticker Ticker (case-sensitive)
#* @trade_size
#* @post /submit_trade
function(rit_port=9999, rit_key, ticker, trade_size) {
    # Simulation must be running to submit API orders
    url <- paste0("http://localhost:", as.character(rit_port), "/v1/orders")
    if (trade_size>0) {
        this_order <- POST(
            paste0(url, "?ticker=", as.character(ticker), "&action=BUY&type=MARKET&quantity=", as.character(trade_size)), 
            add_headers('X-API-Key' = rit_key), 
            timeout(3)
        )
        status <- "Trading"
    } else if (trade_size<0) {
        this_order <- POST(
            paste0(url, "?ticker=", as.character(-ticker), "&action=SELL&type=MARKET&quantity=", as.character(trade_size)), 
            add_headers('X-API-Key' = rit_key), 
            timeout(3)
        )
        status <- "Trading"
    } else {
        status <- "Idle"
    }
}