#ifndef TOKEN_H
#define TOKEN_H

#include <string>

class Token {
public:
	enum class Type {
		SEMICOLON = 0,
		DO,
		END,
		WHILE,
		REPEAT,
		UNTIL,
		IF,
		THEN,
		ELSEIF,
		ELSE,
		FOR,
		IN,
		FUNCTION,
		LOCAL,
		RETURN,
		BREAK,
		DOT,
		COLON,
		COMMA,
		ASSIGN,
		LEFT_SQUARE_BRACKET,
		RIGHT_SQUARE_BRACKET,
		LEFT_CURLY_BRACKET,
		RIGHT_CURLY_BRACKET,
		LEFT_CURLY_PARENTHESIS,
		RIGHT_CURLY_PARENTHESIS,
		NIL,
		FALSE,
		TRUE,
		VARGS,
		NUMBER,
		STRING,
		ADD,
		SUB,
		MUL,
		DIV,
		POW,
		MOD,
		CONCAT,
		LESS,
		LESS_EQUAL,
		GREAT,
		GREAT_EQUAL,
		EQUAL,
		NOT_EQUAL,
		AND,
		OR,
		NOT,
		LEN,
		VAR
	};

	Token(Type type, const char *text)
	:type_(type)
	,text_(text) {

	}
	Token(Type type, const char *text, size_t len)
	:type_(type)
	,text_(text, len) {

	}
	~Token() {}

	const Type& type() const {
		return type_;
	}

	void print ();

private:
	Type type_;
	std::string text_;
};



#endif