#include <iostream>
#include <cstdint>

#include "lexer.h"

int main(){
	std::list<Token> tokens;
	yylex(tokens);
	for(auto &it: tokens){
		it.print();
		std::cout << std::endl;
	}
	return 0;
}