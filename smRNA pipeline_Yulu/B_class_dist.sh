#!/bin/bash
cat name.list | while read i; do
    perl 9.class_length_dist.pl $i
done
