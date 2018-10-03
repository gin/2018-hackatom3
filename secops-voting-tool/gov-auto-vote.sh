#!/bin/bash

################################################################################
# Overview:
#   Auto vote "Abstain" on new proposals
#
# Dependencies:
#   jq
#   gaiacli
#   bash: because of eval in for-loop range use while-loop and +1 for POSIX way
#
# Install dependencies:
#   $ sudo apt install jq
#
# Quick start:
#   Change the variables `accaddr`, `user`, `chain_id` under "# User Settings"
#   $ export SUPER_SECRET=<validator_signing_password>
#   $ bash gov-auto-vote.sh
#
# Future improvements:
#   Make it POSIX-compliant so any shell can run this script
#   Add notification to SMS/Slack/etc when there is a new proposal
################################################################################

# Checks for unset variables and environmental variables
set -u

# User Settings
accaddr=cosmosaccaddr182ujqw3r8p5fffjqkf0rxzj29pg5q96nxd2khq
user=umbrella
chain_id=gaia-8001
pw=$SUPER_SECRET

# Sometimes, sequence is off when voting if `--sequence` flag is not set.
# This seems to solve it.
sequence=$(gaiacli account $accaddr | jq .value.sequence | xargs)

proposal_prev=$(gaiacli gov query-proposals | tail -n 1 | cut -d'-' -f1 | xargs)

while true
do
	proposal_curr=$(gaiacli gov query-proposals | tail -n 1 | cut -d'-' -f1 | xargs)
	if [ $proposal_curr -gt $proposal_prev ]; then
		echo "$(date +"%Y-%m-%d, %T") - New proposal #$proposal_curr.  Previous: #$proposal_prev"
		proposal_not_voted=$(($proposal_prev + 1))
		for proposal_id in `eval echo {$proposal_not_voted..$proposal_curr}`
		do
			echo "PROPOSAL ID:"
			echo $proposal_id
			sequence=$(gaiacli account $accaddr | jq .value.sequence | xargs)
			echo $pw |
				gaiacli gov vote --from=$user --chain-id=$chain_id --option=Abstain --proposal-id=$proposal_id --sequence=$sequence
			sleep 1
		done
		proposal_prev=$proposal_curr
	else
		echo "$(date +"%Y-%m-%d, %T") - No new proposal. Latest: #$proposal_curr"
	fi
done
