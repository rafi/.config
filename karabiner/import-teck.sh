#!/bin/sh

cli=/Applications/Karabiner.app/Contents/Library/bin/karabiner

$cli set repeat.wait 70
/bin/echo -n .
$cli set repeat.initial_wait 400
/bin/echo -n .
$cli set parameter.keyoverlaidmodifier_timeout 300
/bin/echo -n .
$cli set remap.shiftR2shiftR_escape 1
/bin/echo -n .
$cli set remap.shiftL2controlL 1
/bin/echo -n .
/bin/echo
