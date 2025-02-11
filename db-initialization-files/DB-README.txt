The files in this folder are written for MSSQL. If we don't use MSSQL, then certain changes will have to be made
  since a MySQL server instance has slightly different syntax. That being said, there may be syntactic errors
  present even if we do use an MSSQL server because I learned to work using MySQL and there are basically no lint
  systems out there (including the official tools for some reason). To the best of my knowledge, these work. If   there are any errors, they can be fixed pretty easily.

There are dependencies present in the files that require that they be set in a particular order. They are numbered 
  0 to 8, likely with more on the way to create views, stored procedures, functions, triggers, or whatever else.
  The first four files (that's files 0 to 3) must be run in that order. All others (files 4 to 8) contain no
  dependencies outside of the first four files and so can be run in any order.