#!/bin/bash
value=`curl -s --data '{"jsonrpc":"2.0", "method":"eth_blockNumber","params":[],"id":67}' -H "Content-Type: application/json" -X POST $1 | jq -r '.result'`
var=`printf %d $value`
echo 本地高度：$var

value2=`curl -s --data '{"jsonrpc":"2.0", "method":"eth_blockNumber","params":[],"id":67}' -H "Content-Type: application/json" -X POST https://rpc.xdaichain.com | jq -r '.result'`
var2=`printf %d $value2`
echo 琏上高度：$var2

