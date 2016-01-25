NAME = counter

CC_OPTS = -Wall -Werror --std=c11
LD_OPTS = -lprussdrv

PASM_INCL_OPTS ?= -I/usr/include/

.PHONY: all
all: $(NAME)

.PHONY: clean
clean:
	rm *.o $(NAME) $(NAME)_bin.h

$(NAME).o: $(NAME).c $(NAME)_bin.h
	gcc $(CC_OPTS) -c $< -o $@

$(NAME): $(NAME).o
	gcc $(CC_OPTS) $(LD_OPTS) $^ -o $@

$(NAME)_bin.h: $(NAME).p
	pasm -V3 $(PASM_INCL_OPTS) -c $^ -C$(NAME)
