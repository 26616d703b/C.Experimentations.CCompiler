%{
	#include <stdio.h>
%}

%union {
  
	double vallex;
	char *id;
	struct S{double value; enum{unknown, integer, real, boolean, character, string, erreur_type} type;} eval;
}

%token <vallex>INTEGER REAL CHAR STRING
%token INT_T REAL_T BOOL_T CHAR_T STRING_T
%token OP_LT OP_GT OP_LE OP_GE OP_EQ OP_NE
%token WHILE DO
%token <id>ID

%type <eval> Affectation Declaration Declaration_Type Expression Identificator

%left OP_OR
%left OP_AND
%right '!' '='
%nonassoc OP_LT OP_MT OP_LE OP_ME OP_EQ OP_NE
%left '+' '-'
%left '*' '/'
%right OP_UMIN

%start Instruction

%%

Instruction :
	Declaration ';' {
							( $1.type != erreur_type) ? printf("[Declaration] : Pas d'erreur de type!\n") : printf("[Declaration] : Erreur de type!\n");
						}
	| Affectation ';' {
							( $1.type != erreur_type) ? printf("[Affectation] : Pas d'erreur de type!\n") : printf("[Affectation] : Erreur de type!\n");
						}
	| Expression ';' {  
						switch ($1.type) {
							case integer:
								printf("[Expression] ->Resultat : %d\n", (int)$1.value);
								printf("->Type: Entier\n");
								break;
							case real:
								printf("[Expression] ->Resultat : %f\n", $1.value);
								printf("->Type : Reel\n");
								break;
							case boolean:
								( $1.value == 1.0 ) ? printf("[Expression] ->Condition : vraie\n") : printf("[Expression] ->Condition : fausse\n");
								break;
							case erreur_type:
								printf("[Expression] : Erreur de type!\n");
								break;
							default:
							break;
						}
					}
    | While
    ;
	
Declaration:
	Declaration_Type Identificator      {
												$2.type = $1.type;
												$$.type = $1.type;
										}
	| Declaration_Type Affectation		{
												if ( $1.type == $2.type ) {
													
													printf("[Affectation] : Pas d'erreur de type!\n");
													$$.type = $1.type;
												}
												else {
													printf("[Affectation] : Erreur de type!\n");
													$$.type = erreur_type;
												}
										}
	;
	
Affectation:
	Identificator '=' Expression					{ 
											$1.type = $3.type;
											$$.type = $1.type;
											$1.value = $3.value;
											$$.value = $1.value;
										}
	;
	
Declaration_Type:
	INT_T									{
												$$.type = integer;
											}
	| REAL_T								{
												$$.type = real;
											}
	| BOOL_T								{
												$$.type = boolean;
											}
	| CHAR_T								{
												$$.type = character;
											}
	| STRING_T								{
												$$.type = string;
											}
	;

Expression :
	INTEGER								{ 
											$$.type = integer; 
											$$.value = $1; 
										}
	| REAL								{ 
											$$.type = real; 
											$$.value = $1; 
										}
	| CHAR								{
											$$.type = character;
										}
	| STRING							{
											$$.type = string;
											
										}
	| Identificator						{
											$$.type = $1.type;
										}
	| Expression OP_OR Expression		{
											if ( $1.type == boolean && $3.type == boolean ) {
						
												$$.type = boolean;
												$$.value = ( $1.value || $3.value );
											}
											else 
												$$.type = erreur_type;
										}
	| Expression OP_AND Expression    	{
											if ( $1.type == boolean && $3.type == boolean ) {
						
												$$.type = boolean;
												$$.value = ( $1.value && $3.value );
											}
											else 
												$$.type = erreur_type;
										}
	| '!' Expression					{
											if ( $2.type == boolean ) {
						
												$$.type = boolean;
												$$.value = ( !$2.value );
											}
											else 
												$$.type = erreur_type;
										}
	|'(' Expression ')'					{ 
											$$.type = $2.type; 
											$$.value = $2.value; 
										}
    | Expression '+' Expression       	{ 
											if ( $1.type == integer && $3.type == integer )             $$.type = integer;
											else if ( ($1.type == integer && $3.type == real) 
													|| ($1.type == real && $3.type == integer) 
													|| ($1.type == real && $3.type == real) ) 			$$.type = real;
											else
												$$.type = erreur_type;
					
											$$.value = $1.value + $3.value; 
										}
    | Expression '-' Expression       	{ 
											if ( $1.type == integer && $3.type == integer )     		$$.type = integer;
											else if ( ($1.type == integer && $3.type == real) 
											|| ($1.type == real && $3.type == integer) 
											|| ($1.type == real && $3.type == real) ) 					$$.type = real;
											else
												$$.type = erreur_type;
							
											$$.value = $1.value - $3.value; 
										}
	| Expression '*' Expression       	{ 
											if ( $1.type == integer && $3.type == integer )     $$.type = integer;
											else if ( ($1.type == integer && $3.type == real) 
											|| ($1.type == real && $3.type == integer) 
											|| ($1.type == real && $3.type == real) ) 			$$.type = real;
											else
												$$.type = erreur_type;
							
											$$.value = $1.value * $3.value; 
										}
    | Expression '/' Expression       	{ 
											if ( $1.type == integer && $3.type == integer )     $$.type = integer;
											else if ( ($1.type == integer && $3.type == real) 
											|| ($1.type == real && $3.type == integer) 
											|| ($1.type == real && $3.type == real) ) 			$$.type = real;
											else
												$$.type = erreur_type;
							
											$$.value = $1.value / $3.value; 
										}
	| Expression OP_LT Expression		{ 
											$$.type = boolean; 
											$$.value = ($1.value < $3.value); 
										}
	| Expression OP_MT Expression		{ 
											$$.type = boolean; 
											$$.value = ($1.value > $3.value); 
										}
	| Expression OP_LE Expression     	{ 
											$$.type = boolean; 
											$$.value = ($1.value <= $3.value); 
										}
	| Expression OP_ME Expression     	{ 
											$$.type = boolean; 
											$$.value = ($1.value >= $3.value); 
										}
	| Expression OP_EQ Expression     	{ 
											$$.type = boolean; 
											$$.value = ($1.value == $3.value); 
					}
	| Expression OP_NE Expression     	{ 
											$$.type = boolean; 
											$$.value = ($1.value != $3.value); 
										}
	| '-' Expression %prec OP_UMIN 		{
											if ( ($2.type == integer) || ($2.type == real) ) 
												$$.type = $2.type;
											else 
												$$.type = erreur_type;
									
											$$.value = -$2.value;
										}
    ;
	
While:
	WHILE '(' Expression ')' Instruction       {
													( $3.type == boolean ) ? printf("[While] : Pas d'erreur de type!\n") : printf("[While] : Erreur de type!\n");
												}
	|DO Instruction WHILE '(' Expression ')' ';'{
													( $5.type == boolean ) ? printf("[While] : Pas d'erreur de type!\n") : printf("[While] : Erreur de type!\n");
												}
	;
	
Identificator:
	ID									{
											$$.type = unknown;
										}
	;

%%

int yyerror (char *s) {
       
	fprintf(stderr, "%s\n", s);
    return 0;
}

int main(void) {
              
	yyparse();
	system("PAUSE");
	
    return 0;
}
