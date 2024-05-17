#!/bin/bash

export USING_EXWM=t
exec dbus-launch --exit-with-session emacs -mm --debug-init
