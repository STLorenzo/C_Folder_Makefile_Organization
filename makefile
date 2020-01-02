# Makefile

SRC_FOLDER=src
H_FOLDER=headers
O_FOLDER=objects

CC=gcc
CFLAGS=-I$(H_FOLDER) # Look in directory for headers -I(directory) note: written all together

# Example that includes the math library in compilation
LIBS = -lm

# $(patsubst PATTERN,REPLACEMENT,TEXT) 
# In this case patsubst picks each _DEPS files and adds H_FOLDER behind to form H_FOLDER/_DEPS(file)
_DEPS = hellomake.h
DEPS = $(patsubst %, $(H_FOLDER)/%, $(_DEPS))

_OBJ = HelloWorld.o hellofunc.o
OBJ = $(patsubst %, $(O_FOLDER)/%, $(_OBJ))

URL = https://github.com/pipematin/C_Folder_Makefile_Organization.git

# %.o all files with .o sufix
# $@ (the rule) item in the left side of the : 
# $^ dependency list (all the right side of the : )
# $< first item in dependency list (right side of the : )

$(O_FOLDER)/%.o: $(SRC_FOLDER)/%.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

HelloWorld: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)


# To use this rules write: make (rule)
# Example: make execute
execute:
	./HelloWorld

# .PHONY clean -> keeps make from doing something with a file named clean
.PHONY: clean

# core ->file with information about program state when it crashed. 
# Created when this happen if core dumps are enabled: Segmentation fault(core dumped) 
clean:
	rm -f HelloWorld $(O_FOLDER)/*.o *~ core $(H_FOLDER)/*~

git-init:
	git init

git-remote:
	git remote add origin $(URL)

git-add:
	git add .

git-commit:
	git commit -m "commited from makefile"

git-push:
	git push origin master

# First create an empty repository in git
git-first-of-all: git-init git-remote
	 
git-upload: git-add git-commit git-push

# git pull (your repository url)
git-download:
	git pull $(URL)
