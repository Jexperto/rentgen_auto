#!/bin/sh

input_json="/opt/xray/config/config.json"
output_json="/opt/xray/config/config.json"
user_nickname=""

usage() {
  echo "Usage: $0 --input <value> --output <value> --nickname <value>"
  echo
  echo "Options:"
  echo "  --input   The input xray config filepath. Optional. Default - /opt/xray/config/config.json"
  echo "  --output The output xray config filepath. Optional. Default - /opt/xray/config/config.json"
  echo "  --nickname Human readable user nickname without whitespaces"
  echo
  return
}

while [[ "$1" != "" ]]; do
    case $1 in
      --input )
        shift
        input_json="$1"
        ;;
      --output )
        shift
        output_json="$1"
        ;;
      --nickname )
        shift
        user_nickname="$1"
        ;;
      * )
        echo "Invalid argument: $1" 1>&2
        return
        ;;
    esac
    shift
done

if [[ "$user_nickname" =~ [[:space:]] ]]; then
  echo "User nickname cannot contain any whitespaces>"
  return
fi

# Check if jq is installed
if ! command -v jq &> /dev/null
then
    echo "jq could not be found. Please install jq to run this script."
    return
fi

echo "Generating SHORT_ID..."
CLIENT_SHORT_ID=$(source /opt/xray/scripts/_gen_short.sh)

mkdir -p "/opt/xray/config/clients"
mkdir "/opt/xray/config/clients/$CLIENT_SHORT_ID"

echo "Generating UUID..."
CLIENT_UUID=$(/opt/xray/xray uuid)

echo "$CLIENT_UUID" > "/opt/xray/config/clients/$CLIENT_SHORT_ID/uuid"
echo "$user_nickname" > "/opt/xray/config/clients/$CLIENT_SHORT_ID/nickname"

temp_json=$(mktemp)

# Update the JSON file
jq --arg uuid "$CLIENT_UUID" \
   --arg short_id "$CLIENT_SHORT_ID" \
   --arg nickname "$user_nickname" \
   '
   # Modify objects within the inbounds array where protocol is "vless"
   .inbounds |= map(
      if .protocol == "vless" then
        .settings.clients += [
          {
            id: $uuid,
            email: (if $nickname != "" then ($nickname + "@" + "reality") else null end),
            flow: "xtls-rprx-vision"
          }
        ] |
        .streamSettings.realitySettings.shortIds += [$short_id]
      else
        .
      end
   )
   ' "$input_json" > "$temp_json"

mv "$temp_json" "$output_json"

# Inform the user of the update
echo "Updated JSON saved to $output_json"


echo "Added user with UUID: $CLIENT_UUID and short_id: $CLIENT_SHORT_ID"
