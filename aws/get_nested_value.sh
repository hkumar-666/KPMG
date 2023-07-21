#!/bin/bash

get_nested_value() {
    local object="$1"
    local key="$2"
    local value=$(echo "$object" | jq -r ".$key")
    echo "$value"
}

# Example usage:
object_1='{"a": {"b": {"c": "d"}}}'
key_1="a.b.c"
value_1=$(get_nested_value "$object_1" "$key_1")
echo "$value_1"  # Output: d

object_2='{"x": {"y": {"z": "a"}}}'
key_2="x.y.z"
value_2=$(get_nested_value "$object_2" "$key_2")
echo "$value_2"  # Output: a

