%{
    #include "y.tab.h"
%}

%%

"int"						return INT_T;
"float"|"double"			return REAL_T;
"bool"						return BOOL_T;
"char"						return CHAR_T;
"char*"|"string"			return STRING_T;

"while"						return WHILE;
"do"						return DO;

[0-9]+  					{
								yylval.vallex = atoi(yytext);
								return INTEGER;
							}
[+-]?[0-9]+("."[0-9]+)?([eE][+-]?[0-9]+)?		{
								yylval.vallex = atof(yytext);
								return REAL;
							}
[a-zA-Z_][0-9a-zA-Z_]*		{
								return ID;
							}
'.'							return CHAR;		
"\""[^\"]*"\""				return STRING;
							
"<"							return OP_LT;
">"							return OP_MT;
"<="						return OP_LE;
">="						return OP_ME;
"=="						return OP_EQ;
"!="						return OP_NE;
"||"						return OP_OR;
"&&"						return OP_AND;

[-+*/%!=)(;]  				return *yytext;
[ \t\n]    					;/* On ignore les espaces */
.       					yyerror("Caractere non reconnu!");

%%

int yywrap(void) {
        
	return 1;
}

