#!/bin/bash



# DATA=$(curl -s 'https://api.beta.bom.gov.au/apikey/v1/forecasts/1hourly/658/223?timezone=Australia%2FSydney' \
#         -H 'accept: application/json' \
#         -H 'accept-language: en-GB,en-US;q=0.9,en;q=0.8' \
#         -H 'cache-control: no-cache' \
#         -H 'origin: https://beta.bom.gov.au' \
#         -H 'pragma: no-cache' \
#         -H 'priority: u=1, i' \
#         -H 'referer: https://beta.bom.gov.au/' \
#         -H 'sec-ch-ua: "Chromium";v="133", "Not(A:Brand";v="99"' \
#         -H 'sec-ch-ua-mobile: ?0' \
#         -H 'sec-ch-ua-platform: "Linux"' \
#         -H 'sec-fetch-dest: empty' \
#         -H 'sec-fetch-mode: cors' \
#         -H 'sec-fetch-site: same-site' \
#         -H 'user-agent: Mozilla/5.0 (X11; Linux aarch64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36')
#
# echo $DATA


DATA= curl -s 'https://api.beta.bom.gov.au/apikey/v1/observations/latest/66214/atm/surf_air?include_qc_results=false' \
        -H 'accept: application/json, */*;q=0.8' \
        -H 'accept-language: en-GB,en-US;q=0.9,en;q=0.8' \
        -H 'cache-control: no-cache' \
        -H 'origin: https://beta.bom.gov.au' \
        -H 'pragma: no-cache' \
        -H 'priority: u=1, i' \
        -H 'referer: https://beta.bom.gov.au/' \
        -H 'sec-ch-ua: "Not:A-Brand";v="24", "Chromium";v="134"' \
        -H 'sec-ch-ua-mobile: ?0' \
        -H 'sec-ch-ua-platform: "Linux"' \
        -H 'sec-fetch-dest: empty' \
        -H 'sec-fetch-mode: cors' \
        -H 'sec-fetch-site: same-site' \
        -H 'user-agent: Mozilla/5.0 (X11; Linux aarch64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36' 
# | jq '."obs"."temp"."dry_bulb_1min_cel"'

obs = $(echo $DATA | jq '."obs"')

temp_data = $(echo $obs | jq '."temp"')

temp_real = $(echo $temp_data | jq '."dry_bulb_1min_cel"')


if [[ $(echo $DATA | jq '.errors') != 'null' ]]
then
    echo "ERROR"
else
    echo -n "⛅ "
    echo $DATA | jq '.fcst[1]."1hourly"[] | select(."time_utc"=="'$(date -u -d '+1 day' +"%Y-%m-%dT%H:00:00Z")'")."atm"."surf_air"."temp_apparent_cel"'
fi



# echo "⛅" $TEMP

# code1: {
#     precis: 'Sunny'
#   },
#   code2: {
#     precis: 'Clear'
#   },
#   code3: {
#     precis: 'Mostly sunny',
#     alternatePrecis: 'Mostly clear'
#   },
#   code4: {
#     precis: 'Cloudy'
#   },
#   code5: {
#     precis: ''
#   },
#   code6: {
#     precis: 'Hazy'
#   },
#   code7: {
#     precis: ''
#   },
#   code8: {
#     precis: 'Light rain',
#     alternatePrecis: 'Possible rain'
#   },
#   code9: {
#     precis: 'Windy'
#   },
#   code10: {
#     precis: 'Fog'
#   },
#   code11: {
#     precis: 'Shower or two',
#     alternatePrecis: 'Showers'
#   },
#   code12: {
#     precis: 'Rain at times',
#     alternatePrecis: 'Heavy rain'
#   },
#   code13: {
#     precis: 'Dusty'
#   },
#   code14: {
#     precis: 'Frost'
#   },
#   code15: {
#     precis: 'Possible snow',
#     alternatePrecis: 'Snow'
#   },
#   code16: {
#     precis: 'Possible storm'
#   },
#   code17: {
#     precis: 'Possible shower'
#   },
#   code18: {
#     precis: 'Heavy shower or two',
#     alternatePrecis: 'Heavy showers'
#   },
#   code19: {
#     precis: 'Cyclone'
#   }
# }
