#!/bin/bash

get_build_arg() {
  comment_line="#.*"
  # [:word:] does not work
  word="[A-Za-z0-9_]"
  # [:space:] does not work
  space="[ \t\r\n\v\f]"

  undesired_line_beginning="export$space*"
  ending_with_desired_line_output_1="$undesired_line_beginning$word*=$word*"
  ending_with_desired_line_output_2="$undesired_line_beginning$word*"
 
  if [[ $1 =~ $comment_line ]]; then
    echo "";
  elif [[ $1 =~ $ending_with_desired_line_output_1 || $1 =~ $ending_with_desired_line_output_2 ]]; then
    # STRING="artifact-1_2_3_bip_zip"; OUTPUT="${STRING#*-}"; echo "\"${OUTPUT%.*}\"" >>> "1_2_3_bip_zip"
    # ‘#pattern’ removes pattern so long as it matches the beginning of STRING.
    # ‘%pattern’ removes pattern so long as it matches the end of STRING
    echo "${1#$undesired_line_beginning}";
  else
    echo "";
  fi
}

get_build_args_exp() {
  build_args_exp=""
  cur_build_arg=""
  ((line_counter=0))

  # || [ -n "$line" ]
  # is needed to read last line of the file
  # does not read empty line
  while IFS="" read -r line || [ -n "$line" ]; do
    
    cur_build_arg=$(get_build_arg "$line");
    
    if [[ $cur_build_arg != "" ]]; then
    
      if [[ $line_counter != 0 ]]; then
        build_args_exp+=" ";
      fi

      build_args_exp+="--build-arg $cur_build_arg"; 
      ((line_counter++));
    fi
  
  done < $1;
  echo "$build_args_exp";
}