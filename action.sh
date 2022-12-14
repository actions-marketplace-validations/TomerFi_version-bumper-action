#!/bin/bash

# Copyright Tomer Figenblat.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# execute script into variable
output=$(/usr/local/scripts/entrypoint.sh --changelog $1 --preset $2 --label $3 --repopath $4 --bumpoverride $5)
# split output members from the variable
read new_version next_dev_iteration <<<$(cut -f1,2 -d" " <<<$output)
# split out major, minor, patch versions
read major_part <<<$(cut -f1 -d"." <<<"$new_version")
read minor_part <<<$(cut -f2 -d"." <<<"$new_version")
read patch_part <<<$(cut -f3 -d"." <<<"$new_version")
read patch_next_dev <<<$(cut -f3- -d"." <<<"$next_dev_iteration")
# set action outputs
echo "new_version=$new_version" >> $GITHUB_OUTPUT
echo "next_dev_iteration=$next_dev_iteration" >> $GITHUB_OUTPUT
echo "major_part=$major_part" >> $GITHUB_OUTPUT
echo "minor_part=$minor_part" >> $GITHUB_OUTPUT
echo "patch_part=$patch_part" >> $GITHUB_OUTPUT
echo "patch_next_dev=$patch_next_dev" >> $GITHUB_OUTPUT
