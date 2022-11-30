# Pre-requesites

https://docs.yoctoproject.org/3.1.20/brief-yoctoprojectqs/brief-yoctoprojectqs.html

# How to

```
git submodule update --init --checkout
. init-build da3050
export SMPIP="123.456.789.012"
bitbake sample1 && scp tmp/deploy/images/imx8mm-var-dart/sample1-imx8mm-var-dart.smpc* root@${SMPIP}:/var/containers/ && ssh root@${SMPIP} restart
```
