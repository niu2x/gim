%option noyywrap nodefault yylineno


%{

#include "lexer.h"
#include "token.h"

namespace {
std::list<Token> *tokens_ptr = nullptr;
void push_token(Token::Type type, const char *text) {
	tokens_ptr->emplace_back(type, text);
}

void push_token(Token::Type type, const char *text, size_t len) {
    tokens_ptr->emplace_back(type, text, len);
}

std::string string_value;

};


%}


%x STR_QUAT_1 STR_QUAT_2 
%x STR_BRACKET_0 STR_BRACKET_1 
%x STR_BRACKET_2 STR_BRACKET_3 
%x STR_BRACKET_4 STR_BRACKET_5 
%x STR_BRACKET_6 STR_BRACKET_7 
%x STR_BRACKET_8 STR_BRACKET_9 
%%

<STR_QUAT_2>\\\"                {string_value += yytext;}
<STR_QUAT_2>\"                  {string_value += yytext; BEGIN(INITIAL); push_token(Token::Type::STRING, string_value.c_str());}
<STR_QUAT_2>[^\n]               {string_value += yytext;}
\"                              {BEGIN(STR_QUAT_2); string_value = "\"";}
<STR_QUAT_1>\\\'                {string_value += yytext;}
<STR_QUAT_1>\'                  {string_value += yytext; BEGIN(INITIAL); push_token(Token::Type::STRING, string_value.c_str());}
<STR_QUAT_1>[^\n]               {string_value += yytext;}
\'                              {BEGIN(STR_QUAT_1); string_value = "'";}
<STR_BRACKET_0>\]\]             {string_value += yytext; BEGIN(INITIAL); push_token(Token::Type::STRING, string_value.c_str());}
<STR_BRACKET_0>(.)|(\n)         {string_value += yytext;}
\[\[                            {BEGIN(STR_BRACKET_0); string_value = "[[";}
<STR_BRACKET_1>\]=\]            {string_value += yytext; BEGIN(INITIAL); push_token(Token::Type::STRING, string_value.c_str());}
<STR_BRACKET_1>(.)|(\n)         {string_value += yytext;}
\[=\[                           {BEGIN(STR_BRACKET_1); string_value = "[=[";}
<STR_BRACKET_2>\]==\]           {string_value += yytext; BEGIN(INITIAL); push_token(Token::Type::STRING, string_value.c_str());}
<STR_BRACKET_2>(.)|(\n)         {string_value += yytext;}
\[==\[                          {BEGIN(STR_BRACKET_2); string_value = "[==[";}
<STR_BRACKET_3>\]===\]          {string_value += yytext; BEGIN(INITIAL); push_token(Token::Type::STRING, string_value.c_str());}
<STR_BRACKET_3>(.)|(\n)         {string_value += yytext;}
\[===\[                         {BEGIN(STR_BRACKET_3); string_value = "[===[";}
<STR_BRACKET_4>\]====\]         {string_value += yytext; BEGIN(INITIAL); push_token(Token::Type::STRING, string_value.c_str());}
<STR_BRACKET_4>(.)|(\n)         {string_value += yytext;}
\[====\[                        {BEGIN(STR_BRACKET_4); string_value = "[=====[";}
<STR_BRACKET_5>\]=====\]        {string_value += yytext; BEGIN(INITIAL); push_token(Token::Type::STRING, string_value.c_str());}
<STR_BRACKET_5>(.)|(\n)         {string_value += yytext;}
\[=====\[                       {BEGIN(STR_BRACKET_5); string_value = "[======[";}
<STR_BRACKET_6>\]======\]       {string_value += yytext; BEGIN(INITIAL); push_token(Token::Type::STRING, string_value.c_str());}
<STR_BRACKET_6>(.)|(\n)         {string_value += yytext;}
\[======\[                      {BEGIN(STR_BRACKET_6); string_value = "[=======[";}
<STR_BRACKET_7>\]=======\]      {string_value += yytext; BEGIN(INITIAL); push_token(Token::Type::STRING, string_value.c_str());}
<STR_BRACKET_7>(.)|(\n)         {string_value += yytext;}
\[=======\[                     {BEGIN(STR_BRACKET_7); string_value = "[========[";}
<STR_BRACKET_8>\]========\]     {string_value += yytext; BEGIN(INITIAL); push_token(Token::Type::STRING, string_value.c_str());}
<STR_BRACKET_8>(.)|(\n)         {string_value += yytext;}
\[========\[                    {BEGIN(STR_BRACKET_8); string_value = "[=========[";}
<STR_BRACKET_9>\]=========\]    {string_value += yytext; BEGIN(INITIAL); push_token(Token::Type::STRING, string_value.c_str());}
<STR_BRACKET_9>(.)|(\n)         {string_value += yytext;}
\[==========\[                  {BEGIN(STR_BRACKET_9); string_value = "[==========[";}
;                               {push_token(Token::Type::SEMICOLON, yytext);}
do                              {push_token(Token::Type::DO, yytext);}
end                             {push_token(Token::Type::END, yytext);}
repeat                          {push_token(Token::Type::REPEAT, yytext);}
until                           {push_token(Token::Type::UNTIL, yytext);}
if                              {push_token(Token::Type::IF, yytext);}
then                            {push_token(Token::Type::THEN, yytext);}
elseif                          {push_token(Token::Type::ELSEIF, yytext);}
else                            {push_token(Token::Type::ELSE, yytext);}
for                             {push_token(Token::Type::FOR, yytext);}
in                              {push_token(Token::Type::IN, yytext);}
function                        {push_token(Token::Type::FUNCTION, yytext);}
local                           {push_token(Token::Type::LOCAL, yytext);}
return                          {push_token(Token::Type::RETURN, yytext);}
break                           {push_token(Token::Type::BREAK, yytext);}
\.                              {push_token(Token::Type::DOT, yytext);}
,                               {push_token(Token::Type::COMMA, yytext);}
==                              {push_token(Token::Type::EQUAL, yytext);}
~=                              {push_token(Token::Type::NOT_EQUAL, yytext);}
=                               {push_token(Token::Type::ASSIGN, yytext);}
\[                              {push_token(Token::Type::LEFT_SQUARE_BRACKET, yytext);}
\]                              {push_token(Token::Type::RIGHT_SQUARE_BRACKET, yytext);}
\{                              {push_token(Token::Type::LEFT_CURLY_BRACKET, yytext);}
\}                              {push_token(Token::Type::RIGHT_CURLY_BRACKET, yytext);}
\(                              {push_token(Token::Type::LEFT_CURLY_PARENTHESIS, yytext);}
\)                              {push_token(Token::Type::RIGHT_CURLY_PARENTHESIS, yytext);}
nil                             {push_token(Token::Type::NIL, yytext);}
false                           {push_token(Token::Type::FALSE, yytext);}
true                            {push_token(Token::Type::TRUE, yytext);}
\.\.\.                          {push_token(Token::Type::VARGS, yytext);}
[-]?[0-9]+(\.[0-9]+)?           {push_token(Token::Type::NUMBER, yytext);}
\+                              {push_token(Token::Type::ADD, yytext);}
-                               {push_token(Token::Type::SUB, yytext);}
\*                              {push_token(Token::Type::MUL, yytext);}
\/                              {push_token(Token::Type::DIV, yytext);}
%                               {push_token(Token::Type::MOD, yytext);}
\^                              {push_token(Token::Type::POW, yytext);}
\.\.                            {push_token(Token::Type::CONCAT, yytext);}
\<=                             {push_token(Token::Type::LESS_EQUAL, yytext);}
\<                              {push_token(Token::Type::LESS, yytext);}
\>=                             {push_token(Token::Type::GREAT_EQUAL, yytext);}
\>                              {push_token(Token::Type::GREAT, yytext);}
and                             {push_token(Token::Type::AND, yytext);}
or                              {push_token(Token::Type::OR, yytext);}
not                             {push_token(Token::Type::NOT, yytext);}
#                               {push_token(Token::Type::LEN, yytext);}
[_a-zA-Z][a-zA-Z_0-9]*          {push_token(Token::Type::VAR, yytext);}
[ \t\n\r]                       {}
:                               {push_token(Token::Type::COLON, yytext);}
--[^\n]*                        {}
.                               {fprintf(stderr, "unrecognized token %s at line: %d\n", yytext, yylineno); exit(1);}    



%%

int yylex (std::list<Token> &tokens) {
    yylineno = 1;
	tokens_ptr = &tokens;
	auto result = yylex();
	tokens_ptr = nullptr;

    if(YYSTATE != INITIAL){
        fprintf(stderr, "unexpected EOF\n");
        exit(1);
    }
	return result;
}