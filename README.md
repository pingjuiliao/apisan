# APISan: Sanitizing API Usages through Semantic Cross-Checking

APISAN is a tool that automatically infers correct API usages from source code without manual effort. The key idea in APISAN is to extract likely correct usage patterns in four different aspects (e.g., causal relation, and semantic relation on arguments) by considering semantic constraints. APISAN is tailored to check various properties with security implications. We applied APISAN to 92 million lines of code, including Linux Kernel, and OpenSSL, found 76 previously unknown bugs, and provided patches for all the bugs.

This repository has analysis tool and LLVM. LLVM related files follow their own license(LICENSE.LLVM), and analysis tool is provided under the terms of the MIT license.

## How to use in docker
build image
```
docker build -t apisan:latest .
```

run image
```
docker run -it --rm apisan:latest
```

test: same as normal usage
```
root@docker# cd test/return-value
root@docker# ../../apisan build make
root@docker# ../../apisan check --checker=rvchk
```

## NOTE
### changed file:
**analyzer/bin/main.py**  
In docker, #! cannot be deteced except that it's in the first line, so the MIT license line is deleted.
gonna change it back

### required package:
- libboost-all-dev: for SymExecExtractor.cpp  
- python2: for old cmake compatibility  
- python3: for apisan python script  

### other
- Decision: not using setup.sh for docker  
  - requires 'bash ./setup.sh' to perform pushd/popd correctly.
  - we can see the building progress but there will be no files in LLVM_BUILD_DIR, i.e. bin/llvm
  - The building process does not complain about missing <boost/...> libraries
- 'cmake -B<build_dir> -H<source_dir>' cannot be used due to old cmake version.

## How to use
- Tested in Ubuntu 14.04
- Setup
```sh
  $ ./setup.sh
```
- How to build symbolic database
```sh
  $ apisan build [cmds]
```
- Run './configure'
```sh
  $ apisan build ./configure
  $ apisan build make
```
- How to run a checker
```sh
  $ apisan check --db=[db] --checker=[checker]
```
- Example
```sh
  $ cd test/return-value
  $ ../../apisan build make
  $ ../../apisan check --checker=rvchk
```

## Checkers (under analyzer/apisan/check)
- Return value checker: retval.py
- Argument checker: argument.py
- Causality checker: causality.py
- Condition checker: condition.py
- Integer overflow checker: intovfl.py
- Format string bug checker: fsb.py

## Authors
- Insu Yun <insu@gatech.edu>
- Changwoo Min <changwoo@gatech.edu>
- Xujie Si <six@gatech.edu>
- Yeongjin Jang <yeongjin.jang@gatech.edu> 
- Taesoo Kim <taesoo@gatech.edu>
- Mayur Naik <naik@cc.gatech.edu>

## Publications
```
@inproceedings{yun:apisan,
  title        = {{APISan: Sanitizing API Usages through Semantic Cross-checking}},
  author       = {Insu Yun and Changwoo Min and Xujie Si and Yeongjin Jang and Taesoo Kim and Mayur Naik},
  booktitle    = {Proceedings of the 25th USENIX Security Symposium (Security)},
  month        = aug,
  year         = 2016,
  address      = {Austin, TX},
}
```
