There are dependencies present in the files that require that they be set in a particular order. They are numbered 
  0 to 8, likely with more on the way to create views, stored procedures, functions, triggers, or whatever else.
  The first four files (that's files 0 to 3) must be run in that order. All others (files 4 to 8) contain no
  dependencies outside of the first four files and so can be run in any order.