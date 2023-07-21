#!/bin/bash

# Function to query the instance metadata
function get_instance_metadata() {
    # AWS instance metadata endpoint
    local metadata_endpoint="http://169.254.169.254/latest/meta-data/"

    # Retrieve all metadata keys
    local metadata_keys=$(curl -s $metadata_endpoint)

    # Initialize an empty JSON object
    local json_output="{"

    # Loop through each metadata key and get its value
    for key in $metadata_keys; do
        local value=$(curl -s "${metadata_endpoint}${key}")
        json_output+="\"$key\":\"$value\","
    done

    # Remove the trailing comma and close the JSON object
    json_output=${json_output%,*}
    json_output+="}"

    echo "$json_output"
}

# Get the instance metadata in JSON format
instance_metadata_json=$(get_instance_metadata)

# Print the JSON-formatted output
echo "$instance_metadata_json"

