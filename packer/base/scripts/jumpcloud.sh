#!/bin/bash
set -e

curl --silent --show-error --header 'x-connect-key: 742502a44e0afaace6bfd914f824fd2d9d7a10cd' https://kickstart.jumpcloud.com/Kickstart | bash
