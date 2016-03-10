%token ARGC ARGV
%token BOOLEEN NOMBRE_BASE_8 NOMBRE_BASE_10 NOMBRE_BASE_16 REEL CARACTERE CHAINE
%token TYPE TYPE_S TYPE_Q PREPROCESSEUR
%token IDENTIFICATEUR
%token COMMENTAIRE_COURT COMMENTAIRE_LONG
%token OPERATEUR_I OPERATEUR_D OPERATEUR_AFFECTATION OPERATEUR_CALCUL OPERATEUR_LOGIQUE_BINAIRE OPERATEUR_FLUX_ENTRANT OPERATEUR_FLUX_SORTANT OPERATEUR_BIT_A_BIT OPERATEUR_COMPARAISON OPERATEUR_ACCES
%token SCANF PRINTF CIN COUT
%token IF ELSE FOR WHILE DO REPEAT UNTIL SWITCH CASE BREAK CONTINUE
%token RETURN SIZEOF ENUM STRUCT UNION DEFAULT GOTO ASM TYPEOF ALIGNOF

%start Fonction

%nonassoc IF ELSE OPERATEUR_COMPARAISON

%right OPERATEUR_AFFECTATION OPERATEUR_BIT_A_BIT OPERATEUR_I OPERATEUR_D
%right '!' ':' MOINS_UNAIRE

%left OPERATEUR_CALCUL OPERATEUR_LOGIQUE_BINAIRE OPERATEUR_FLUX_ENTRANT OPERATEUR_FLUX_SORTANT OPERATEUR_ACCES
%left ',' '.' '(' '[' '|' '^' '&'


%%

Fonction:
	TYPE IDENTIFICATEUR '(' ')' Bloc_Instructions								{ printf("Fonction -> TYPE IDENTIFICATEUR '(' ')' Bloc_Instructions	\n"); }
	;

Bloc_Instructions:
	'{'  Suite_Instructions  '}'												{ printf("Bloc_Instructions -> { Suite_Instructions }		\n"); }
	|'{' '}'																	{ printf("Bloc_Instructions -> { }	\n"); }
	;
	
Suite_Instructions:
	Instruction Suite_Instructions												{ printf("Suite_Instructions -> Instruction Suite_Instructions		\n"); }
	|Instruction																{ printf("Suite_Instructions -> Instruction		\n"); }
	;
	
Instruction:
	Declaration ';'																{ printf("Instruction -> Declaration ;	\n"); }
	|Affectation ';'															{ printf("Instruction -> Affectation ;	\n"); }
	|Expression ';'																{ printf("Instruction -> Expression ;		\n"); }
	|Instruction_Lecture ';'													{ printf("Instruction -> Instruction_Lecture ;	\n"); }
	|Instruction_Ecriture ';'													{ printf("Instruction -> Instruction_Ecriture ;	\n"); }
	|Instruction_If																{ printf("Instruction -> Instruction_If		\n"); }
	|Instruction_For															{ printf("Instruction -> Instruction_For	\n"); }
	|Instruction_While															{ printf("Instruction -> Instruction_While	\n"); }
	;
	
Instruction_Lecture:
	SCANF '(' CHAINE ',' IDENTIFICATEUR ')'										{ printf("Instruction_Lecture -> SCANF ( CHAINE , IDENTIFICATEUR )	\n"); }
	|CIN Flux_Entrant															{ printf("Instruction_Lecture -> CIN Flux_Sortant	\n"); }
	;
	
Flux_Entrant:
	OPERATEUR_FLUX_ENTRANT Expression											{ printf("Flux_Entrant -> OPERATEUR_FLUX_ENTRANT Expression		\n"); }
	;	
	
Instruction_Ecriture:
	PRINTF '(' Expression ')'													{ printf("Instruction_Ecriture -> PRINTF ( Expression )	\n"); }
	|COUT  Flux_Sortant															{ printf("Instruction_Ecriture -> COUT Flux_Sortant		\n"); }
	;
	
Flux_Sortant:
	OPERATEUR_FLUX_SORTANT Expression Flux_Sortant								{ printf("Flux_Sortant -> OPERATEUR_FLUX_SORTANT \" Expression \" Flux_Sortant	\n"); }
	|OPERATEUR_FLUX_SORTANT Expression											{ printf("Flux_Sortant -> OPERATEUR_FLUX_SORTANT \" Expression \"	\n"); }
	;
	
Instruction_If:
	IF '(' Expression ')' Instruction_ou_Bloc ELSE Instruction_ou_Bloc			{ printf("Instruction_If -> IF ( Expression ) Instruction_ou_Bloc ELSE Instruction_ou_Bloc	\n"); }
	|IF '(' Expression ')' Instruction_ou_Bloc									{ printf("Instruction_If -> IF ( Expression ) Instruction_ou_Bloc	\n"); }
	;
	
Instruction_ou_Bloc:
	Bloc_Instructions															{ printf("Instruction_ou_Bloc -> Bloc_Instructions	\n"); }
	|Instruction																{ printf("Instruction_ou_Bloc -> Instruction		\n"); }
	;
	
Instruction_For:
	FOR '(' Expression ';' Expression ';' Expression ')' Bloc_Instructions		{ printf("Instruction_For -> FOR ( Expression ; Expression ; Expression ) Bloc_Instructions		\n"); }
	|FOR '(' Expression ';' Expression ';' Expression ')' Instruction			{ printf("Instruction_For -> FOR ( Expression ; Expression ; Expression ) Instruction	\n"); }
	;
	
Instruction_While:
	WHILE '(' Expression ')' Bloc_Instructions									{ printf("Instruction_While -> WHILE ( Expression ) Bloc_Instructions	\n"); }
	|DO  Bloc_Instructions  WHILE '(' Expression ')' ';'						{ printf("Instruction_While -> DO Bloc_Instructions WHILE ( Expression ) ;		\n"); }
	|WHILE '(' Expression ')' Instruction										{ printf("Instruction_While -> WHILE ( Expression ) Instruction		\n"); }
	|DO Instruction WHILE '(' Expression ')' ';'								{ printf("Instruction_While -> DO Instruction WHILE ( Expression ) ;	\n"); }
	;
	
Declaration:
	TYPE Identificateur_ou_Affectation											{ printf("Declaration -> TYPE Identificateur_ou_Affectation	\n"); }
	;
	
Identificateur_ou_Affectation:
	IDENTIFICATEUR ',' Identificateur_ou_Affectation							{ printf("Identificateur_ou_Affectation -> IDENTIFICATEUR ',' Identificateur_ou_Affectation	\n"); }
	|Affectation ',' Identificateur_ou_Affectation								{ printf("Identificateur_ou_Affectation -> Affectation ',' Identificateur_ou_Affectation	\n"); }
	|IDENTIFICATEUR																{ printf("Identificateur_ou_Affectation -> IDENTIFICATEUR	\n"); }
	|Affectation																{ printf("Identificateur_ou_Affectation -> Affectation		\n"); }
	;
	
Affectation:
	IDENTIFICATEUR OPERATEUR_AFFECTATION Expression								{ printf("Affectation -> IDENTIFICATEUR OPERATEUR_AFFECTATION Expression	\n"); }
	;
	
Expression:
	OPERATEUR_I IDENTIFICATEUR													{ printf("Expression -> OPERATEUR_I IDENTIFICATEUR	\n"); }
	|OPERATEUR_D IDENTIFICATEUR													{ printf("Expression -> OPERATEUR_D IDENTIFICATEUR	\n"); }
	|IDENTIFICATEUR OPERATEUR_I													{ printf("Expression -> IDENTIFICATEUR OPERATEUR_I	\n"); }
	|IDENTIFICATEUR OPERATEUR_D													{ printf("Expression -> IDENTIFICATEUR OPERATEUR_D	\n"); }
	|Expression OPERATEUR_CALCUL Expression										{ printf("Expression -> Expression OPERATEUR_CALCUL Expression	\n"); }
	|Expression OPERATEUR_BIT_A_BIT Expression									{ printf("Expression -> Expression OPERATEUR_CALCUL Expression	\n"); }
	|Expression OPERATEUR_COMPARAISON Expression								{ printf("Expression -> Expression OPERATEUR_COMPARAISON Expression		\n"); }
	|Expression OPERATEUR_LOGIQUE_BINAIRE Expression							{ printf("Expression -> Expression OPERATEUR_LOGIQUE_BINAIRE Expression		\n"); }
	|'(' Expression ')'															{ printf("Expression -> ( Expression )	\n"); }
	|'!' Expression																{ printf("Expression -> ! Expression	\n"); }
	|'-' Expression	%prec MOINS_UNAIRE											{ printf("Expression -> - Expression	\n"); }
	|Constante																	{ printf("Expression -> Constante	\n"); }
	|IDENTIFICATEUR																{ printf("Expression -> IDENTIFICATEUR	\n"); }
	;
	
Constante:
	NOMBRE_BASE_10																{ printf("Constante -> NOMBRE_BASE_10	\n"); }
	|REEL																		{ printf("Constante -> REEL	\n"); }
	|CARACTERE																	{ printf("Constante -> CARACTERE	\n"); }
	|CHAINE																		{ printf("Constante -> CHAINE	\n"); }
	|BOOLEEN																	{ printf("Constante -> BOOLEEN	\n"); }
	;
	