## Bowling Calculator

### Dependencies
- **docker** 
- **docker-compose** 

### Description
- This project implements a bowling score calculator based on a specified score card template for a 10-pin
bowling game. It receives the relative path of the score-card (according to the template),
and prints in the console the calculated score information.

### Installing
- The project uses docker and docker-compose to simplify the setup/manage dependencies. To set up, run:
``` bash
  bin/docker_setup.sh
```

### Using
- To use the calculator in general, use the following template:
``` bash
  docker-compose run calculator <command>
```
- Look at the [```./docker_entrypoint.sh```](docker_entrypoint.sh) for examples of available commands.
- The command used to run the calculator given a score file would be:
``` bash
  docker-compose run calculator calc <RELATIVE_PATH_TO_FILE>
```
- Please note that the score-file must be present in the project folder
- Check the [```spec/examples/valid/regular.txt```](regular.txt) for an example of the score format

### Testing
- The test suite uses Rspec for unit testing and Rubocop for code quality:
- Using docker:
  - docker-compose run calculator lint
  - docker-compose run calculator test