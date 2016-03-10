%{
	#include <stdlib.h>		
	#include "y.tab.h"
%}

argc						"argc"
argv						"argv"
chiffre 					[0-9]
lettre 						[a-zA-Z]
caractere					'[^\r\t\n]'
booleen						"true"|"false"
nombre_base_8				0[1-7]*
nombre_base_10 				[+-]?{chiffre}+
nombre_base_16 	        	0x[0-9A-F]+
exposant 					[eE][+-]?{nombre_base_10}
reel 						[+-]?{nombre_base_10}("."{nombre_base_10})?{exposant}?
chaine						"\""[^\"]*"\""
preprocesseur				#("define"|"undef"|"include"|"if"|"ifdef"|"ifndef"|"else"|"elif"|"endif"|"line"|"error"|"warning"|"pragma")
scanf						"scanf"
printf						"printf"
cin							"cin"
cout						"cout"
if							"if"
else						"else"
return						"return"
sizeof						"sizeof"
enum						"enum"
struct						"struct"
union						"union"
while						"while"
do							"do"
break						"break"
for							"for"
switch						"switch"
case						"case"
default						"default"
continue					"continue"
goto						"goto"
asm							"asm"
typeof						"typeof"
alignof						"alignof"
type						"bool"|"char"|"char16_t"|"char32_t"|"double"|"float"|"int"|"long"|"short"|"signed"|"unsigned"|"void"|"wchar_t"
type_s						"extern"|"static"|"register"|"inline"|"auto"
type_q						"const"|"volatile"|"restrict"					
typedef						"typedef"
mot_cle						"alignas"|"alignof"|"and"|"and_eq"|"asm"|"auto"|"bitand"|"bitor"|"bool"|"break"|"case"|"catch"|"char"|"char16_t"|"char32_t"|"class"|"compl"|"const"|"constexpr"|"const_cast"|"continue"|"decltype"|"default"|"delete"|"do"|"double"|"dynamic_cast"|"else"|"enum"|"explicit"|"export"|"extern"|"false"|"float"|"for"|"friend"|"goto"|"if"|"inline"|"int"|"long"|"mutable"|"namespace"|"new"|"noexcept"|"not"|"not_eq"|"nullptr"|"operator"|"or"|"or_eq"|"private"|"protected"|"public"|"register"|"reinterpret_cast"|"repeat"|"return"|"short"|"signed"|"sizeof"|"static"|"static_assert"|"static_cast"|"struct"|"switch"|"template"|"this"|"thread_local"|"throw"|"true"|"try"|"typedef"|"typeid"|"typename"|"union"|"unsigned"|"until"|"using"|"virtual"|"void"|"volatile"|"wchar_t"|"while"|"xor"|"xor_eq"
identificateur 	        	{lettre}(_|{lettre}|{chiffre})*
commentaire_court			"//".*
commentaire_long			"/*"([^\*]|(\*[^/]*))*"*/"
operateur_affectation		"="|"+="|"-="|"*="|"/="|"%="|"&="|"|="|"^="|"<<="|">>="
operateur_i					"++"
operateur_d					"--"
operateur_calcul			"+"|"-"|"*"|"/"|"%"
operateur_flux_entrant		">>"
operateur_flux_sortant		"<<"
operateur_bit_a_bit			"&"|"|"|"^"|"<<"|">>"
operateur_logique_binaire	"&&"|"||"
operateur_comparaison		"=="|"!="|"<"|">"|"<="|">="
operateur_acces				"*"|"&"|"->"|"."|"->*"|".*"

%%

[ \r\t\n]+								;
{argc}									return(ARGC);
{argv}									return(ARGV);
{caractere}								return(CARACTERE);
{booleen}								return(BOOLEEN);
{nombre_base_8}							return(NOMBRE_BASE_8);
{nombre_base_10} 						return(NOMBRE_BASE_10);
{nombre_base_16}						return(NOMBRE_BASE_16);
{reel}									return(REEL);
{chaine}								return(CHAINE);
{preprocesseur}							return(PREPROCESSEUR);
{scanf}									return(SCANF);
{printf}								return(PRINTF);
{cin}									return(CIN);
{cout}									return(COUT);
{if}									return(IF);
{else}									return(ELSE);
{return}								return(RETURN);
{sizeof}								return(SIZEOF);
{enum}									return(ENUM);
{struct}								return(STRUCT);
{union}									return(UNION);
{while}									return(WHILE);
{do}									return(DO);
{break}									return(BREAK);
{for}									return(FOR);
{switch}								return(SWITCH);
{case}									return(CASE);
{default}								return(DEFAULT);
{continue}								return(CONTINUE);
{goto}									return(GOTO);
{asm}									return(ASM);
{typeof}								return(TYPEOF);
{alignof}								return(ALIGNOF);
{type}									return(TYPE);
{type_s}								return(TYPE_S);
{type_q}								return(TYPE_Q);
{identificateur}						return(IDENTIFICATEUR);
{commentaire_court}						return(COMMENTAIRE_COURT);
{commentaire_long}						return(COMMENTAIRE_LONG);
{operateur_affectation}					return(OPERATEUR_AFFECTATION);
{operateur_i}							return(OPERATEUR_I);
{operateur_d}							return(OPERATEUR_D);
{operateur_calcul}						return(OPERATEUR_CALCUL);
{operateur_flux_entrant}				return(OPERATEUR_FLUX_ENTRANT);
{operateur_flux_sortant}				return(OPERATEUR_FLUX_SORTANT);
{operateur_bit_a_bit}					return(OPERATEUR_BIT_A_BIT);
{operateur_logique_binaire}				return(OPERATEUR_LOGIQUE_BINAIRE);
{operateur_comparaison}					return(OPERATEUR_COMPARAISON);
{operateur_acces}						return(OPERATEUR_ACCES);
[\*\+(){},;:.\-/%&|~?!=\[\]] 			return yytext[0];
.										yyerror();

%%

int main (void) {
	
	if ( yyparse() == 0 )
		printf("Chaine reconnue!\n");
	
	return 0;
}

int yywrap(void) {

	return 1;
}

int yyerror(void) {

	printf("Erreur de syntaxe!\n");
	system("PAUSE");
	return(1);
}
