# hackatom3-secops-patch-tool
Patch and vulnerability management tooling and workflows

## Overview
Blue-green deployment to minimize downtime.  
Symlink is almost instant.  
Given block time is around 5 seconds, this is quick enough to not miss blocks.
1. Store new build in a unique directory  
e.g. directory named after build tag

2. Symlink changes the running binary's path to the new build's  
e.g.
```
Before
~/cosmos/current/ --> ~/cosmos/v0.24.1/

After
~/cosmos/current/ --> ~/cosmos/v0.24.2/
```

3. Restart `gaiad`

## Quick start
```sh
$ cd cosmos-sdk && git checkout <TAG>
$ make get_tools && make get_vendor_deps && make install

$ sh ~/2018-hackatom/secops-patch-tool/deploy.sh
```

## Future improvements
- Add notification to SMS/Slack/etc when there is a new tag in cosmos-sdk