grammar grama;

grama
	: funcao* 'main' '{' bloco '}' funcao*
	;

bloco
	:
	| declaraVariavel ';'
	| atribuicaoVariavel ';'
	| chamadaFuncao ';'
	| if
	| while
	;

declaraVariavel
	: type ID
	;

type
    : 'int'
	| 'char'
	| 'string'
	| 'float'
	;

funcao
	: type declaracaoSimbolo '(' declaracaoSimbolo (',' declaracaoSimbolo)* ')' '{' bloco '}'
	;

declaracaoSimbolo
	: 'a'..'z' ID
	;

while
	: 'while' '(' condicao ')' '{' bloco '}'
	;

if
	 : 'if' '(' condicao ')' '{' bloco '}' ('else' '{' bloco '}')?
	 ;

condicao
	: 'true'
	| 'false'
	| '(' ID (operacaoBooleana) ID ')' (operacaoBooleana condicao)?
	;

operacaoBooleana
	: '!='
	| '=='
	| '||'
	| '&&'
	| '~'
	| '>'
	| '<'
	| '>='
	| '<='
	;

chamadaFuncao
	 : ID '(' ID (',' ID )* ')'
	 ;

atribuicaoVariavel
	 : ID '=' expressao
	 ;

// Colocar precedencia de parenteses e verificar prioriodades das operacoes artimeticas
expressao
    :
	| (ID | chamadaFuncao) (operacaoAritmetica expressao)?
	| '(' expressao ')'
	;

operacaoAritmetica
	: '+'
	| '-'
	| '*'
	| '/'
	;

ID  :	('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'0'..'9'|'_')*
    ;

INT :	'0'..'9'+
    ;

COMMENT
    :   '//' ~('\n'|'\r')* '\r'? '\n' {$channel=HIDDEN;}
    |   '/*' ( options {greedy=false;} : . )* '*/' {$channel=HIDDEN;}
    ;

STRING
    :  '"' ( ESC_SEQ | ~('\\'|'"') )* '"'
    ;

CHAR:  '\'' ( ESC_SEQ | ~('\''|'\\') ) '\''
    ;

fragment
HEX_DIGIT : ('0'..'9'|'a'..'f'|'A'..'F') ;

fragment
ESC_SEQ
    :   '\\' ('b'|'t'|'n'|'f'|'r'|'\"'|'\''|'\\')
    |   UNICODE_ESC
    |   OCTAL_ESC
    ;

fragment
OCTAL_ESC
    :   '\\' ('0'..'3') ('0'..'7') ('0'..'7')
    |   '\\' ('0'..'7') ('0'..'7')
    |   '\\' ('0'..'7')
    ;

fragment
UNICODE_ESC
    :   '\\' 'u' HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT
    ;