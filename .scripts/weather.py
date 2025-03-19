#!/bin/python3

import json

import requests

# This website is awesome
# https://curlconverter.com/


def main():
    headers = {
        "accept": "application/json, */*;q=0.8",
        "accept-language": "en-GB,en-US;q=0.9,en;q=0.8",
        "cache-control": "no-cache",
        "origin": "https://beta.bom.gov.au",
        "pragma": "no-cache",
        "priority": "u=1, i",
        "referer": "https://beta.bom.gov.au/",
        "sec-ch-ua": '"Not:A-Brand";v="24", "Chromium";v="134"',
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": '"Linux"',
        "sec-fetch-dest": "empty",
        "sec-fetch-mode": "cors",
        "sec-fetch-site": "same-site",
        "user-agent": "Mozilla/5.0 (X11; Linux aarch64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36",  # noqa
    }
    params = {
        "include_qc_results": "false",
    }
    response = requests.get(
        "https://api.beta.bom.gov.au/apikey/v1/observations/latest/66214/atm/surf_air",
        params=params,
        headers=headers,
    )

    if response.text[0] == "<":
        return "ERROR"

    data = response.json()
    # print(data)

    obs = data["obs"]
    # print(obs)

    temp_data = obs["temp"]
    temp_real = float(temp_data["dry_bulb_1min_cel"])
    temp_apparent = float(temp_data["apparent_1min_cel"])

    wind_speed_mps = float(obs["wind"]["speed_10m_mps"])
    wind_speed_kmh = wind_speed_mps * 3.6

    precip = "unknown"

    # {"text": "$text", "alt": "$alt", "tooltip": "$tooltip", "class": "$class", "percentage": $percentage }

    text = f"⛅ {temp_real:.1f}°"
    tooltip = f"feels like: {temp_apparent: .1f}°, 💨: {int(wind_speed_kmh)}km/h"
    return {"text": text, "alt": "blah", "tooltip": tooltip}


if __name__ == "__main__":
    try:
        print(json.dumps(main()))
    except KeyError:
        print("INVALID DATA. key error")
