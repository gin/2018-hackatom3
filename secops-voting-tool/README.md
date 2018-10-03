# hackatom3-secops-voting-tool
Other validator tasks that would benefit from automation

## Overview
Auto vote "Abstain" on new proposals

## Dependencies
- jq
- gaiacli
- bash: because of eval in for-loop range use while-loop and +1 for POSIX way

## Install dependencies
```sh
$ sudo apt install jq
```
## Quick start
Change the variables `accaddr`, `user`, `chain_id` under "# User Settings"
```sh
$ export SUPER_SECRET=<validator_signing_password>
$ bash gov-auto-vote.sh
```

## Future improvements
- Make it POSIX-compliant so any shell can run this script
- Add notification to SMS/Slack/etc when there is a new proposal
