#!/bin/bash

A=$( yad --entry --title='Start Process' --entry-label='Command:' )

bash -c $A
