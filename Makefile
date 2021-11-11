##
## EPITECH PROJECT, 2021
## makefile
## File description:
## makefile
##

all:
	rm -f wolfram
	stack build
	cp .stack-work/install/x86_64-linux-tinfo6/*/8.8.4/bin/azerty-exe .
	mv azerty-exe wolfram

clean:
	stack clean

fclean:
	stack purge

re:	fclean all

.PHONY:	all clean fclean re
