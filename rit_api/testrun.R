renv::activate("~/Downloads/Smith/TA/COMM420/R/r_env")

pr("api.R") %>% pr_run(port=8000)
# API documentation - http://127.0.0.1:8000/__docs__/


# On a Windows machine, use a ssh tunnel to forward the RIT client traffic
# ssh -f -N -L 9999:localhost:9999 jn78@jieniuu8.theworkpc.com

# Install SSH on windows
# https://github.com/PowerShell/Win32-OpenSSH/wiki/Install-Win32-OpenSSH

"
curl --request GET \
  --url 'http://127.0.0.1:8000/rit_status?rit_key=A7XHB46SJN'
"

"
curl --request GET \
  --url 'http://127.0.0.1:8000/position?rit_key=A7XHB46SJN'
"

"
curl --request GET \
  --url 'http://127.0.0.1:8000/timeremainder?rit_key=A7XHB46SJN'
"

"
curl --request POST \
  --url 'http://127.0.0.1:8000/submit_trade?rit_key=A7XHB46S&ticker=SPY&trade_size=69'
"