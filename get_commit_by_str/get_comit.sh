#!/bin/bash

awk -f get_fid_step1.awk  tmp.txt | awk -f get_fid_step2.awk | awk -f get_fid_step3.awk |sort -k1 -n| awk -f get_real_commit.awk
