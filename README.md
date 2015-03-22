# robot_navigator

###Valid inputs

1. PLACE 0,0,EAST
2. MOVE,LEFT,RIGHT,REPORT

###Invalid inputs assumptions

1. PLACE invalidinputsassumptions
2. A line with gibberish string
3. PLACE 3,3,giberrishstring


###Instructions to run code

1. Ensure that a file with the name **input.txt** is in the same directory
2. Run the code by executing the command to read from STDIN

 ```ruby
  ruby -r "./read_input.rb" -e "ReadInput.instruction_from_file"
 ```
 or from **input.txt**

 ```ruby
  cat input.txt | ruby -r "./read_input.rb" -e "ReadInput.instruction_from_file"
```

3. Test file, **robot_test.rb** is included

