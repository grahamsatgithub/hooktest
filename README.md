# hooktest

https://dev.azure.com/grahamnorth/hooktest/_build?definitionId=1

This is just basic test of deploying IAC using pipeline automation

1. pull down the code (git clone ...)
2. make change to anything, usually the terraform
3. commit and push (git add ..., git commit..., git push)
4. See the pipeline run in the link above
5. If everything run correctly you should see stuff here:

https://portal.azure.com/#blade/HubsExtension/BrowseResource/resourceType/Microsoft.Network%2FvirtualNetworks
"test-nae-vnet-test"
