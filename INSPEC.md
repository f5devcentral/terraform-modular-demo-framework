

## Are they there are working?
```bash
inspec exec test/xc-ready --input-file=testparams.yaml --controls=aws-site-online azure-site-online discovery-publishing
```

## Are they disposed of as expected?
```bash
inspec exec test/xc-ready --input-file=testparams.yaml --controls=aws-site-does-not-exist azure-site-does-not-exist discovery-does-not-exists
```