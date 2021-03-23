#ifndef LEXER_H
#define LEXER_H

#include <list>

#include "token.h"

extern int yylex (std::list<Token> &tokens);

#endif